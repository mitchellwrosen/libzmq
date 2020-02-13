{-# LANGUAGE UndecidableInstances #-}

module Zmq.Socket
  ( nonThreadsafeWaitUntilCanRecv
  , nonThreadsafeWaitUntilCanSend
  ) where

import Data.Bits ((.&.))

import Zmq.API.GetSockOpt (getSocketEventState, getSocketFd)
import Zmq.Prelude
import qualified Zmq.FFI as FFI


nonThreadsafeWaitUntilCanRecv
  :: Ptr FFI.Socket
  -> IO ()
nonThreadsafeWaitUntilCanRecv =
  nonThreadsafeWaitUntilCan FFI.zMQ_POLLIN

nonThreadsafeWaitUntilCanSend
  :: Ptr FFI.Socket
  -> IO ()
nonThreadsafeWaitUntilCanSend =
  nonThreadsafeWaitUntilCan FFI.zMQ_POLLOUT

nonThreadsafeWaitUntilCan
  :: CInt
  -> Ptr FFI.Socket
  -> IO ()
nonThreadsafeWaitUntilCan events socket = do
  fd <- getSocketFd socket

  fix \again -> do
    threadWaitRead fd -- "read" is not a typo
    state <- getSocketEventState socket
    -- http://api.zeromq.org/4-3:zmq-getsockopt
    --
    -- The combination of a file descriptor returned by
    -- the ZMQ_FD option being ready for reading but no
    -- actual events returned by a subsequent retrieval of
    -- the ZMQ_EVENTS option is valid; applications should
    -- simply ignore this case and restart their polling
    -- operation/event loop.
    unless ( state .&. events /= 0 ) again