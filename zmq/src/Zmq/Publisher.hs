module Zmq.Publisher
  ( Publisher,
    open,
    bind,
    unbind,
    connect,
    disconnect,
    sends,
    canSend,
  )
where

import Control.Concurrent.MVar
import Data.ByteString (ByteString)
import Data.Coerce (coerce)
import Data.List.NonEmpty qualified as List.NonEmpty
import Data.Text (Text)
import Libzmq
import Zmq.Error (Error)
import Zmq.Internal.Socket (CanSend, Event, Socket (withSocket), ThreadSafeSocket)
import Zmq.Internal.Socket qualified as Socket

-- | A thread-safe __publisher__ socket.
--
-- Valid peers: __subscriber__, __xsubscriber__
newtype Publisher
  = Publisher (MVar Zmq_socket)
  deriving stock (Eq)
  deriving (Socket) via (ThreadSafeSocket)

instance CanSend Publisher

-- | Open a __publisher__.
open :: IO (Either Error Publisher)
open =
  coerce (Socket.openThreadSafeSocket ZMQ_PUB)

-- | Bind a __publisher__ to an __endpoint__.
--
-- /Alias/: 'Zmq.bind'
bind :: Publisher -> Text -> IO (Either Error ())
bind =
  Socket.bind

-- | Unbind a __publisher__ from an __endpoint__.
--
-- /Alias/: 'Zmq.unbind'
unbind :: Publisher -> Text -> IO ()
unbind =
  Socket.unbind

-- | Connect a __publisher__ to an __endpoint__.
--
-- /Alias/: 'Zmq.connect'
connect :: Publisher -> Text -> IO (Either Error ())
connect =
  Socket.connect

-- | Disconnect a __publisher__ from an __endpoint__.
--
-- /Alias/: 'Zmq.disconnect'
disconnect :: Publisher -> Text -> IO ()
disconnect =
  Socket.disconnect

-- | Send a __multiframe message__ on a __publisher__ to all peers.
--
-- This operation never blocks. If a peer has a full message queue, it will not receive the message.
sends :: Publisher -> ByteString -> [ByteString] -> IO (Either Error ())
sends socket0 topic message =
  withSocket socket0 \socket ->
    Socket.sends socket (topic List.NonEmpty.:| message)

-- | /Alias/: 'Zmq.canSend'
canSend :: Publisher -> a -> Event a
canSend =
  Socket.canSend
