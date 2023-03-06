module Zmq.Replier
  ( Replier,
    defaultOptions,
    sendQueueSize,
    open,
    bind,
    unbind,
    connect,
    disconnect,
    send,
    receive,
  )
where

import Data.ByteString (ByteString)
import Data.Text (Text)
import Libzmq
import Numeric.Natural (Natural)
import Zmq.Error (Error, catchingOkErrors)
import Zmq.Internal.Options (Options)
import Zmq.Internal.Options qualified as Options
import Zmq.Internal.Socket (CanReceive, Socket (withSocket), ThreadUnsafeSocket (..))
import Zmq.Internal.Socket qualified as Socket

-- | A __replier__ socket.
--
-- Valid peers: __dealer__, __requester__
newtype Replier
  = Replier ThreadUnsafeSocket
  deriving stock (Eq)
  deriving newtype (Socket)
  deriving anyclass
    ( CanReceive,
      Options.CanSetSendQueueSize
    )

defaultOptions :: Options Replier
defaultOptions =
  Options.defaultOptions

sendQueueSize :: Natural -> Options Replier
sendQueueSize =
  Options.sendQueueSize

-- | Open a __replier__.
open :: Options Replier -> IO (Either Error Replier)
open options =
  catchingOkErrors do
    socket@(ThreadUnsafeSocket zsocket _) <- Socket.openThreadUnsafeSocket ZMQ_REP
    Options.setSocketOptions zsocket options
    pure (Replier socket)

-- | Bind a __replier__ to an __endpoint__.
--
-- /Alias/: 'Zmq.bind'
bind :: Replier -> Text -> IO (Either Error ())
bind =
  Socket.bind

-- | Unbind a __replier__ from an __endpoint__.
--
-- /Alias/: 'Zmq.unbind'
unbind :: Replier -> Text -> IO ()
unbind =
  Socket.unbind

-- | Connect a __replier__ to an __endpoint__.
--
-- /Alias/: 'Zmq.connect'
connect :: Replier -> Text -> IO (Either Error ())
connect =
  Socket.connect

-- | Disconnect a __replier__ from an __endpoint__.
--
-- /Alias/: 'Zmq.disconnect'
disconnect :: Replier -> Text -> IO ()
disconnect =
  Socket.disconnect

-- | Send a __message__ on a __replier__ to the last peer received from.
--
-- If the last peer received from no longer exists, the message is discarded.
send :: Replier -> ByteString -> IO (Either Error ())
send socket0 message =
  catchingOkErrors do
    withSocket socket0 \socket ->
      Socket.sendWontBlock socket message

-- | Receive a __message__ on a __replier__ from any peer (fair-queued).
receive :: Replier -> IO (Either Error ByteString)
receive socket =
  catchingOkErrors do
    withSocket socket Socket.receive
