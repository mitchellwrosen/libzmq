module Zmqhs.Socket
  ( Socket(..)

  , socket
  , close

  , bind
  , unbind

  , connect
  , disconnect
  ) where

import Foreign.C (CInt)
import Foreign.Ptr (Ptr, nullPtr)

import qualified Libzmq
import qualified Zmq.FFI as FFI

import Zmqhs.Context (Context(..))
import Zmqhs.Endpoint (Endpoint, withEndpoint)
import Zmqhs.SocketType (SocketType(..))


newtype Socket
  = Socket
  { unSocket :: Ptr Libzmq.Socket }
  deriving stock ( Eq, Ord, Show )

socket
  :: Context
  -> SocketType
  -> IO ( Either CInt Socket )
socket context socketType = do
  sock <- Libzmq.socket ( unContext context ) ( unSocketType socketType )
  if sock == nullPtr
    then Left <$> FFI.zmq_errno
    else pure ( Right ( Socket sock ) )

close
  :: Socket
  -> IO ()
close sock =
  Libzmq.close ( unSocket sock )

bind
  :: Socket
  -> Endpoint
  -> IO ( Either CInt () )
bind sock endpoint =
  withEndpoint endpoint \endpoint' ->
    Libzmq.bind ( unSocket sock ) endpoint' >>= \case
      0 -> pure ( Right () )
      _ -> Left <$> FFI.zmq_errno

unbind
  :: Socket
  -> Endpoint
  -> IO ( Either CInt () )
unbind sock endpoint =
  withEndpoint endpoint \endpoint' ->
    Libzmq.unbind ( unSocket sock ) endpoint' >>= \case
      0 -> pure ( Right () )
      _ -> Left <$> FFI.zmq_errno

connect
  :: Socket
  -> Endpoint
  -> IO ( Either CInt () )
connect sock endpoint =
  withEndpoint endpoint \endpoint' ->
    Libzmq.connect ( unSocket sock ) endpoint' >>= \case
      0 -> pure ( Right () )
      _ -> Left <$> FFI.zmq_errno

disconnect
  :: Socket
  -> Endpoint
  -> IO ( Either CInt () )
disconnect sock endpoint =
  withEndpoint endpoint \endpoint' ->
    Libzmq.disconnect ( unSocket sock ) endpoint' >>= \case
      0 -> pure ( Right () )
      _ -> Left <$> FFI.zmq_errno