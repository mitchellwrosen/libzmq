{-# OPTIONS_GHC -fno-warn-redundant-constraints #-}

module Zmq.Internal.Options
  ( -- * Options
    Options,
    defaultOptions,
    optionsName,

    -- ** Context options
    setContextOption,
    setContextOptions,
    ioThreads,
    maxSockets,

    -- ** Socket options
    CanSetLossy,
    CanSetSendQueueSize,
    setSocketOptions,
    setSocketOption,
    lossy,
    name,
    sendQueueSize,
  )
where

import Control.Exception
import Data.Int (Int32)
import Data.Text (Text)
import Data.Text qualified as Text
import Libzmq
import Numeric.Natural (Natural)
import Zmq.Error (enrichError, throwOkError, unexpectedError)
import {-# SOURCE #-} Zmq.Internal.Context (Context)
import {-# SOURCE #-} Zmq.Internal.Socket (Socket)

-- TODO linger option for context and socket

data Options socket
  = DefaultOptions
  | ContextOptions (Zmq_ctx -> IO ())
  | SocketOptions (Zmq_socket -> IO ()) !Text

instance Semigroup (Options socket) where
  DefaultOptions <> y = y
  x <> DefaultOptions = x
  ContextOptions x <> ContextOptions y = ContextOptions (x <> y)
  SocketOptions x0 x1 <> SocketOptions y0 y1 = SocketOptions (x0 <> y0) (if Text.null y1 then x1 else y1)
  _ <> _ = DefaultOptions -- type system should prevent this

class CanSetLossy socket

class CanSetSendQueueSize socket

defaultOptions :: Options a
defaultOptions =
  DefaultOptions

optionsName :: Options socket -> Text
optionsName = \case
  SocketOptions _ s -> s
  _ -> Text.empty

------------------------------------------------------------------------------------------------------------------------
-- Context options

setContextOption :: Zmq_ctx -> Zmq_ctx_option -> Int -> IO ()
setContextOption context option value =
  zmq_ctx_set context option value >>= \case
    Left errno ->
      let err = enrichError "zmq_ctx_set" errno
       in case errno of
            EINVAL -> throwIO err
            _ -> unexpectedError err
    Right () -> pure ()

-- Throws ok errors
setContextOptions :: Zmq_ctx -> Options socket -> IO ()
setContextOptions context = \case
  ContextOptions f -> f context
  _ -> pure ()

-- | The number of background IO threads that ØMQ uses.
--
-- As a rule of thumb, each thread can handle 1Gb/sec of data in or out. If your program performs no external socket IO,
-- you can set this value to 0.
--
-- /Default/: 1
ioThreads :: Natural -> Options Context
ioThreads n =
  ContextOptions \context ->
    setContextOption context ZMQ_IO_THREADS (natToInt n)

-- | The maximum number of sockets that can be open at once, after which @open@ will return 'Zmq.EMFILE'.
--
-- /Default/: 1023
maxSockets :: Natural -> Options Context
maxSockets n =
  ContextOptions \context ->
    setContextOption context ZMQ_MAX_SOCKETS (natToInt (min 1 n)) -- 0 is invalid

------------------------------------------------------------------------------------------------------------------------
-- Socket options

-- Throws ok errors
setSocketOption :: Zmq_socket -> Zmq_socket_option a -> a -> IO ()
setSocketOption socket option value =
  zmq_setsockopt socket option value >>= \case
    Left errno ->
      let err = enrichError "zmq_setsockopt" errno
       in case errno of
            EINTR -> throwOkError err
            EINVAL -> throwIO err
            ENOTSOCK -> throwIO err
            ETERM -> throwOkError err
            _ -> unexpectedError err
    Right val -> pure val

-- Throws ok errors
setSocketOptions :: Zmq_socket -> Zmq_socket_type -> Options socket -> IO ()
setSocketOptions socket socketType options =
  case defaults <> options of
    SocketOptions f _name -> f socket
    _ -> pure ()
  where
    -- we flip some defaults:
    --   1. pub/xpub are non-lossy
    defaults :: Options socket
    defaults =
      case socketType of
        ZMQ_DEALER -> defaultOptions
        ZMQ_PAIR -> defaultOptions
        ZMQ_PUB -> notLossy
        ZMQ_PULL -> defaultOptions
        ZMQ_PUSH -> defaultOptions
        ZMQ_REP -> defaultOptions
        ZMQ_REQ -> defaultOptions
        ZMQ_ROUTER -> defaultOptions
        ZMQ_STREAM -> defaultOptions
        ZMQ_SUB -> defaultOptions
        ZMQ_XPUB -> notLossy
        ZMQ_XSUB -> defaultOptions

lossy :: CanSetLossy socket => Options socket
lossy =
  SocketOptions (\socket -> setSocketOption socket ZMQ_XPUB_NODROP 0) Text.empty

-- internal
notLossy :: Options socket
notLossy =
  SocketOptions (\socket -> setSocketOption socket ZMQ_XPUB_NODROP 1) Text.empty

name :: Socket socket => Text -> Options socket
name =
  SocketOptions mempty

sendQueueSize :: CanSetSendQueueSize socket => Natural -> Options socket
sendQueueSize n =
  SocketOptions (\socket -> setSocketOption socket ZMQ_SNDHWM (natToInt32 n)) Text.empty

------------------------------------------------------------------------------------------------------------------------
-- Utils

natToInt :: Natural -> Int
natToInt n =
  if n > fromIntegral @Int @Natural maxBound
    then maxBound @Int
    else fromIntegral @Natural @Int n

natToInt32 :: Natural -> Int32
natToInt32 n =
  if n > fromIntegral @Int32 @Natural maxBound
    then maxBound @Int32
    else fromIntegral @Natural @Int32 n
