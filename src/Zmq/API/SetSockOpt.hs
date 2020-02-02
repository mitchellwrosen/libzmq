module Zmq.API.SetSockOpt
  ( setByteStringSockOpt
  ) where

import qualified Data.ByteString.Unsafe as ByteString

import Zmq.Prelude
import qualified Zmq.FFI as FFI


setByteStringSockOpt
  :: ForeignPtr FFI.Socket
  -> FFI.Sockopt
  -> ByteString
  -> IO CInt
setByteStringSockOpt socket option value =
  withForeignPtr socket \socket_ptr ->
    ByteString.unsafeUseAsCStringLen value \( c_value, len ) ->
      FFI.zmq_setsockopt socket_ptr option c_value ( fromIntegral len )
