{-# LANGUAGE MagicHash #-}
{-# LANGUAGE UnboxedTuples #-}

module Zmq.Internal.Socket
  ( Socket (..),
    CanSend,
    CanReceive,
    ThreadSafeSocket (..),
    ThreadUnsafeSocket (..),
    openThreadUnsafeSocket,
    openThreadSafeSocket,
    setOption,
    bind,
    unbind,
    connect,
    disconnect,
    send,
    send1,
    receive,
    Event,
    canSend,
    canReceive,
    poll,
  )
where

import Control.Concurrent (threadWaitRead)
import Control.Concurrent.MVar
import Control.Exception
import Data.Bits ((.&.))
import Data.ByteString (ByteString)
import Data.Functor ((<&>))
import Data.IORef
import Data.List.NonEmpty qualified as List (NonEmpty)
import Data.List.NonEmpty qualified as List.NonEmpty
import Data.Text (Text)
import Foreign.C.Types (CInt, CShort)
import GHC.Exts (TYPE, UnliftedRep, keepAlive#)
import GHC.IO (IO (..), unIO)
import GHC.IORef (IORef (..))
import GHC.MVar (MVar (..))
import GHC.STRef (STRef (..))
import Libzmq
import Libzmq.Bindings qualified
import System.Posix.Types (Fd (..))
import Zmq.Error (Error, enrichError, unexpectedError)
import Zmq.Internal.Context (Context (..), globalContextRef)
import Zmq.Internal.SocketFinalizer (makeSocketFinalizer)

class Socket socket where
  getSocket :: socket -> (Zmq_socket -> IO a) -> IO a
  getSocket = withSocket

  withSocket :: socket -> (Zmq_socket -> IO a) -> IO a
  withSocket = undefined -- hide "minimal complete definition" haddock

class Socket socket => CanSend socket

class Socket socket => CanReceive socket

newtype ThreadSafeSocket
  = ThreadSafeSocket (MVar Zmq_socket)

instance Socket ThreadSafeSocket where
  getSocket (ThreadSafeSocket socketVar) action = do
    socket <- readMVar socketVar
    action socket

  withSocket (ThreadSafeSocket socketVar) =
    withMVar socketVar

data ThreadUnsafeSocket = ThreadUnsafeSocket
  { socket :: !Zmq_socket,
    canary :: !(IORef ())
  }

instance Eq ThreadUnsafeSocket where
  ThreadUnsafeSocket s0 _ == ThreadUnsafeSocket s1 _ = s0 == s1

instance Ord ThreadUnsafeSocket where
  compare (ThreadUnsafeSocket s0 _) (ThreadUnsafeSocket s1 _) = compare s0 s1

instance Show ThreadUnsafeSocket where
  show (ThreadUnsafeSocket s0 _) = show s0

instance Socket ThreadUnsafeSocket where
  withSocket (ThreadUnsafeSocket socket (IORef canary#)) action =
    IO \s -> keepAlive# canary# s (unIO (action socket))

openThreadUnsafeSocket :: Zmq_socket_type -> IO (Either Error ThreadUnsafeSocket)
openThreadUnsafeSocket =
  openSocket \socket -> do
    canary@(IORef (STRef canary#)) <- newIORef ()
    pure (ThingAndCanary (ThreadUnsafeSocket socket canary) canary#)

openThreadSafeSocket :: Zmq_socket_type -> IO (Either Error (MVar Zmq_socket))
openThreadSafeSocket =
  openSocket \socket -> do
    socketVar@(MVar canary#) <- newMVar socket
    pure (ThingAndCanary socketVar canary#)

data ThingAndCanary a
  = forall (canary# :: TYPE UnliftedRep).
    ThingAndCanary !a canary#

openSocket :: (Zmq_socket -> IO (ThingAndCanary a)) -> Zmq_socket_type -> IO (Either Error a)
openSocket wrap socketType = do
  Context context socketsRef <- readIORef globalContextRef
  mask_ do
    zmq_socket context socketType >>= \case
      Left errno ->
        let err = enrichError "zmq_socket" errno
         in case errno of
              EFAULT -> throwIO err
              EINVAL -> throwIO err
              EMFILE -> pure (Left err)
              ETERM -> pure (Left err)
              _ -> unexpectedError err
      Right socket -> do
        ThingAndCanary thing canary <- wrap socket
        finalizer <- makeSocketFinalizer (zmq_setsockopt socket) (zmq_close socket) canary
        atomicModifyIORef' socketsRef \finalizers -> (finalizer : finalizers, ())
        pure (Right thing)

setOption :: Zmq_socket -> Zmq_socket_option a -> a -> IO (Either Error ())
setOption socket option value = do
  let loop =
        zmq_setsockopt socket option value >>= \case
          Left errno ->
            let err = enrichError "zmq_setsockopt" errno
             in case errno of
                  EINTR -> loop
                  EINVAL -> throwIO err
                  ENOTSOCK -> throwIO err
                  ETERM -> pure (Left err)
                  _ -> unexpectedError err
          Right val -> pure (Right val)
  loop

getIntOption :: Zmq_socket -> CInt -> IO (Either Error Int)
getIntOption socket option = do
  let loop = do
        zmq_getsockopt_int socket option >>= \case
          Left errno ->
            let err = enrichError "zmq_getsockopt" errno
             in case errno of
                  EINTR -> loop
                  EINVAL -> throwIO err
                  ENOTSOCK -> throwIO err
                  ETERM -> pure (Left err)
                  _ -> unexpectedError err
          Right val -> pure (Right val)
  loop

-- | Bind a __socket__ to an __endpoint__.
bind :: Socket socket => socket -> Text -> IO (Either Error ())
bind socket0 endpoint =
  withSocket socket0 \socket -> bind_ socket endpoint

bind_ :: Zmq_socket -> Text -> IO (Either Error ())
bind_ socket endpoint =
  zmq_bind socket endpoint >>= \case
    Left errno ->
      let err = enrichError "zmq_bind" errno
       in case errno of
            EADDRINUSE -> pure (Left err)
            EADDRNOTAVAIL -> throwIO err
            EINVAL -> throwIO err
            EMTHREAD -> pure (Left err)
            ENOCOMPATPROTO -> throwIO err
            ENODEV -> throwIO err
            ENOTSOCK -> throwIO err
            EPROTONOSUPPORT -> throwIO err
            ETERM -> pure (Left err)
            _ -> unexpectedError err
    Right () -> pure (Right ())

-- | Unbind a __socket__ from an __endpoint__.
unbind :: Socket socket => socket -> Text -> IO ()
unbind socket0 endpoint =
  withSocket socket0 \socket -> unbind_ socket endpoint

unbind_ :: Zmq_socket -> Text -> IO ()
unbind_ socket endpoint =
  zmq_unbind socket endpoint >>= \case
    Left errno ->
      let err = enrichError "zmq_unbind" errno
       in case errno of
            -- These aren't very interesting to report to the user; in all cases, we can say "ok, we
            -- disconnected", so we prefer the cleaner return type with no Either.
            EINVAL -> pure ()
            ENOENT -> pure ()
            ENOTSOCK -> pure ()
            ETERM -> pure ()
            _ -> unexpectedError err
    Right () -> pure ()

-- | Connect a __socket__ to an __endpoint__.
connect :: Socket socket => socket -> Text -> IO (Either Error ())
connect socket0 endpoint =
  withSocket socket0 \socket -> connect_ socket endpoint

connect_ :: Zmq_socket -> Text -> IO (Either Error ())
connect_ socket endpoint =
  zmq_connect socket endpoint >>= \case
    Left errno ->
      let err = enrichError "zmq_connect" errno
       in case errno of
            EINVAL -> throwIO err
            EMTHREAD -> pure (Left err)
            ENOCOMPATPROTO -> throwIO err
            ENOTSOCK -> throwIO err
            EPROTONOSUPPORT -> throwIO err
            ETERM -> pure (Left err)
            _ -> unexpectedError err
    Right () -> pure (Right ())

-- | Disconnect a __socket__ from an __endpoint__.
disconnect :: Socket socket => socket -> Text -> IO ()
disconnect socket0 endpoint =
  withSocket socket0 \socket -> disconnect_ socket endpoint

disconnect_ :: Zmq_socket -> Text -> IO ()
disconnect_ socket endpoint =
  zmq_disconnect socket endpoint >>= \case
    Left errno ->
      let err = enrichError "zmq_disconnect" errno
       in case errno of
            -- These aren't very interesting to report to the user; in all cases, we can say "ok, we
            -- disconnected", so we prefer the cleaner return type with no Either.
            EINVAL -> pure ()
            ENOENT -> pure ()
            ENOTSOCK -> pure ()
            ETERM -> pure ()
            _ -> unexpectedError err
    Right () -> pure ()

send :: Zmq_socket -> List.NonEmpty ByteString -> IO (Either Error ())
send socket message =
  let loop = \case
        [frame] -> sendf socket frame False
        frame : frames ->
          sendf socket frame True >>= \case
            Left err -> pure (Left err)
            Right () -> loop frames
        [] -> undefined -- impossible
   in loop (List.NonEmpty.toList message)

send1 :: Zmq_socket -> ByteString -> IO (Either Error ())
send1 socket frame =
  sendf socket frame False

sendf :: Zmq_socket -> ByteString -> Bool -> IO (Either Error ())
sendf socket frame more = do
  let loop = do
        zmq_send_dontwait socket frame more >>= \case
          Left errno ->
            let err = enrichError "zmq_send" errno
             in case errno of
                  EAGAIN ->
                    blockUntilEvent socket Libzmq.Bindings._ZMQ_POLLOUT >>= \case
                      Left err1 -> pure (Left err1)
                      Right () -> loop
                  EFSM -> throwIO err
                  EHOSTUNREACH -> pure (Left err)
                  EINVAL -> throwIO err
                  EINTR -> loop
                  ENOTSUP -> throwIO err
                  ENOTSOCK -> throwIO err
                  ETERM -> pure (Left err)
                  _ -> unexpectedError err
          Right _len -> pure (Right ())
  loop

receive :: Zmq_socket -> IO (Either Error (List.NonEmpty ByteString))
receive socket =
  receivef socket >>= \case
    Left err -> pure (Left err)
    Right (More frame) ->
      receive_ socket <&> \case
        Left err -> Left err
        Right frames -> Right (frame List.NonEmpty.:| reverse frames)
    Right (NoMore frame) -> pure (Right (frame List.NonEmpty.:| []))

receive_ :: Zmq_socket -> IO (Either Error [ByteString])
receive_ socket =
  receivef socket >>= \case
    Left err -> pure (Left err)
    Right (More frame) ->
      receive_ socket <&> \case
        Left err -> Left err
        Right frames -> Right (frame : frames)
    Right (NoMore frame) -> pure (Right [frame])

data ReceiveF
  = More ByteString
  | NoMore ByteString

receivef :: Zmq_socket -> IO (Either Error ReceiveF)
receivef socket =
  bracket zmq_msg_init zmq_msg_close \frame -> do
    let loop = do
          zmq_msg_recv_dontwait frame socket >>= \case
            Left errno ->
              let err = enrichError "zmq_msg_recv" errno
               in case errno of
                    EAGAIN ->
                      blockUntilEvent socket Libzmq.Bindings._ZMQ_POLLIN >>= \case
                        Left err1 -> pure (Left err1)
                        Right () -> loop
                    EFSM -> throwIO err
                    EINTR -> loop
                    ENOTSOCK -> throwIO err
                    ENOTSUP -> throwIO err
                    ETERM -> pure (Left err)
                    _ -> unexpectedError err
            Right _len -> do
              bytes <- zmq_msg_data frame
              zmq_msg_more frame <&> \case
                False -> Right (NoMore bytes)
                True -> Right (More bytes)
    loop

blockUntilEvent :: Zmq_socket -> CShort -> IO (Either Error ())
blockUntilEvent socket event =
  getIntOption socket Libzmq.Bindings._ZMQ_FD >>= \case
    Left err -> pure (Left err)
    Right fd -> do
      let loop = do
            threadWaitRead (fromIntegral @Int @Fd fd)
            getIntOption socket Libzmq.Bindings._ZMQ_EVENTS >>= \case
              Left err1 -> pure (Left err1)
              Right events ->
                if events .&. fromIntegral @CShort @Int event == 0
                  then loop
                  else pure (Right ())
      loop

data Event a
  = forall socket. Socket socket => Event !socket !Zmq_events !a

canSend :: CanSend socket => socket -> a -> Event a
canSend socket =
  Event socket ZMQ_POLLOUT

canReceive :: CanReceive socket => socket -> a -> Event a
canReceive socket =
  Event socket ZMQ_POLLIN

withEventPollitems :: [Event a] -> ([Zmq_pollitem] -> IO b) -> IO b
withEventPollitems events0 action =
  let go acc = \case
        [] -> action (reverse acc)
        Event socket0 events _ : zevents ->
          getSocket socket0 \socket ->
            go (Zmq_pollitem_socket socket events : acc) zevents
   in go [] events0

poll :: [Event a] -> IO (Either Error a)
poll events =
  withEventPollitems events \items0 ->
    zmq_pollitems items0 \items -> do
      let loop =
            zmq_poll items (-1) >>= \case
              Left errno ->
                let err = enrichError "zmq_poll" errno
                 in case errno of
                      EINTR -> loop
                      EFAULT -> throwIO err
                      ETERM -> pure (Left err)
                      _ -> unexpectedError err
              Right zevents -> pure (Right (foldr f undefined (zip events zevents)))
      loop
  where
    f :: (Event a, Zmq_events) -> a -> a
    f (Event _ _ x, zevents) =
      if zevents == Zmq_events 0
        then id
        else const x
