module Zmq.Responder
  ( Responder,
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
import Data.Coerce (coerce)
import Data.List.NonEmpty as List (NonEmpty)
import Libzmq
import Zmq.Endpoint
import Zmq.Error (Error)
import Zmq.Internal.Socket (ThreadUnsafeSocket (..), withThreadUnsafeSocket)
import Zmq.Internal.Socket qualified as Socket

newtype Responder
  = Responder ThreadUnsafeSocket
  deriving stock (Eq)

open :: IO (Either Error Responder)
open =
  coerce (Socket.openThreadUnsafeSocket ZMQ_REP)

bind :: Responder -> Endpoint transport -> IO (Either Error ())
bind (Responder socket0) endpoint =
  withThreadUnsafeSocket socket0 \socket -> Socket.bind socket endpoint

unbind :: Responder -> Endpoint transport -> IO (Either Error ())
unbind (Responder socket0) endpoint =
  withThreadUnsafeSocket socket0 \socket -> Socket.unbind socket endpoint

connect :: Responder -> Endpoint transport -> IO (Either Error ())
connect (Responder socket0) endpoint =
  withThreadUnsafeSocket socket0 \socket -> Socket.connect socket endpoint

disconnect :: Responder -> Endpoint transport -> IO (Either Error ())
disconnect (Responder socket0) endpoint =
  withThreadUnsafeSocket socket0 \socket -> Socket.disconnect socket endpoint

send :: Responder -> List.NonEmpty ByteString -> IO (Either Error ())
send (Responder socket0) message =
  withThreadUnsafeSocket socket0 \socket -> Socket.send socket message

receive :: Responder -> IO (Either Error (List.NonEmpty ByteString))
receive (Responder socket) =
  withThreadUnsafeSocket socket Socket.receive
