module Zmq.API.Bind
  ( bind
  , BindError
  ) where


import Zmq.Endpoint
import Zmq.Exception
import Zmq.Error
import Zmq.Prelude
import qualified Zmq.FFI as FFI


-- |
-- @
-- data BindError
--   = 'EADDRINUSE'
--   | 'EADDRNOTAVAIL'
--   | 'EINVAL'
--   | 'EMTHREAD'
--   | 'ENODEV'
-- @
type BindError
  = Error "bind"

-- | <http://api.zeromq.org/4-3:zmq-bind>
bind
  :: Ptr FFI.Socket
  -> Endpoint transport
  -> IO ( Either BindError () )
bind socket endpoint =
  withEndpoint endpoint \c_endpoint ->
    FFI.zmq_bind socket c_endpoint >>= \case
      0 ->
        pure ( Right () )

      _ ->
        FFI.zmq_errno >>= \case
          EADDRINUSE_    -> pure ( Left EADDRINUSE )
          EADDRNOTAVAIL_ -> pure ( Left EADDRNOTAVAIL )
          EINVAL_        -> pure ( Left EINVAL )
          EMTHREAD_      -> pure ( Left EMTHREAD )
          ENODEV_        -> pure ( Left ENODEV )

          errno ->
            if errno == ETERM_ then
              exception "zmq_bind" errno
            else
              unexpectedErrno "zmq_bind" errno
