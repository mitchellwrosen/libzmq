module Zmq.Context
  ( Context(..)
  , Options(..)
  , defaultOptions
  , newContext
  , terminateContext
  , setIoThreads
  , setMaxSockets
  ) where

import qualified Libzmq
import qualified Zmq.FFI as FFI

import Zmq.Prelude
import qualified Zmq.API.CtxTerm as API


newtype Context
  = Context { unContext :: Ptr Libzmq.Context }

data Options
  = Options
  { ioThreads :: Natural
  , maxSockets :: Natural
  }

defaultOptions :: Options
defaultOptions =
  Options
    { ioThreads = fromIntegral FFI.zMQ_IO_THREADS_DFLT
    , maxSockets = fromIntegral FFI.zMQ_MAX_SOCKETS_DFLT
    }

newContext
  :: MonadIO m
  => Options
  -> m Context
newContext options = liftIO do
  context <- Libzmq.newContext
  setIoThreads context ( ioThreads options )
  setMaxSockets context ( maxSockets options )
  pure ( Context context )

terminateContext
  :: MonadIO m
  => Context
  -> m ()
terminateContext context =
  liftIO ( coerce API.ctxTerm context )


-- TODO move to Zmq.API.CtxSet

setIoThreads
  :: Ptr Libzmq.Context
  -> Natural
  -> IO ()
setIoThreads =
  setNatural FFI.zMQ_IO_THREADS

setMaxSockets
  :: Ptr Libzmq.Context
  -> Natural
  -> IO ()
setMaxSockets =
  setNatural FFI.zMQ_MAX_SOCKETS


----------------------------------------------------------------------------------

setNatural
  :: FFI.Contextopt
  -> Ptr Libzmq.Context
  -> Natural
  -> IO ()
setNatural option context =
    void . FFI.zmq_ctx_set context option . fromIntegral
