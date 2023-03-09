{-# LANGUAGE MagicHash #-}

module Zmq.Internal.ThreadUnsafeSocket
  ( ThreadUnsafeSocket,
    raw,
    name,
    with,
    open,
  )
where

import Data.IORef (IORef, newIORef)
import Data.Text (Text)
import GHC.IORef (IORef (..))
import GHC.STRef (STRef (..))
import Libzmq
import Zmq.Internal.Options (Options)
import Zmq.Internal.Options qualified as Options
import Zmq.Internal.Socket qualified as Socket

data ThreadUnsafeSocket = ThreadUnsafeSocket
  { socket :: !Zmq_socket,
    _name :: !Text,
    canary :: !(IORef ())
  }

instance Eq ThreadUnsafeSocket where
  ThreadUnsafeSocket s0 _ _ == ThreadUnsafeSocket s1 _ _ =
    s0 == s1

instance Ord ThreadUnsafeSocket where
  compare (ThreadUnsafeSocket s0 _ _) (ThreadUnsafeSocket s1 _ _) =
    compare s0 s1

raw :: ThreadUnsafeSocket -> Zmq_socket
raw ThreadUnsafeSocket {socket} =
  socket

name :: ThreadUnsafeSocket -> Text
name ThreadUnsafeSocket {_name} =
  _name

with :: ThreadUnsafeSocket -> (Zmq_socket -> IO a) -> IO a
with ThreadUnsafeSocket {socket} action =
  Socket.keepingSocketAlive socket (action socket)

-- Throws ok errors
open :: Zmq_socket_type -> Options socket -> IO ThreadUnsafeSocket
open socketType options =
  Socket.openWith
    ( \socket -> do
        canary@(IORef (STRef canary#)) <- newIORef ()
        Options.setSocketOptions socket options
        pure $
          Socket.ThingAndCanary
            ThreadUnsafeSocket
              { socket,
                _name = Options.optionsName options,
                canary
              }
            canary#
    )
    socketType

