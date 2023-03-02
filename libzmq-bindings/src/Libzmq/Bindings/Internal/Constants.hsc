{-# LANGUAGE CPP #-}

module Libzmq.Bindings.Internal.Constants (module Libzmq.Bindings.Internal.Constants) where

#include <zmq.h>

import Foreign.C (CInt, CShort)

------------------------------------------------------------------------------------------------------------------------
-- Errors

_EADDRINUSE :: CInt
_EADDRINUSE = #const EADDRINUSE

_EADDRNOTAVAIL :: CInt
_EADDRNOTAVAIL = #const EADDRNOTAVAIL

_EAFNOSUPPORT :: CInt
_EAFNOSUPPORT = #const EAFNOSUPPORT

_ECONNABORTED :: CInt
_ECONNABORTED = #const ECONNABORTED

_ECONNREFUSED :: CInt
_ECONNREFUSED = #const ECONNREFUSED

_ECONNRESET :: CInt
_ECONNRESET = #const ECONNRESET

_EFSM :: CInt
_EFSM = #const EFSM

_EHOSTUNREACH :: CInt
_EHOSTUNREACH = #const EHOSTUNREACH

_EINPROGRESS :: CInt
_EINPROGRESS = #const EINPROGRESS

_EMSGSIZE :: CInt
_EMSGSIZE = #const EMSGSIZE

_EMTHREAD :: CInt
_EMTHREAD = #const EMTHREAD

_ENETDOWN :: CInt
_ENETDOWN = #const ENETDOWN

_ENETRESET :: CInt
_ENETRESET = #const ENETRESET

_ENETUNREACH :: CInt
_ENETUNREACH = #const ENETUNREACH

_ENOBUFS :: CInt
_ENOBUFS = #const ENOBUFS

_ENOCOMPATPROTO :: CInt
_ENOCOMPATPROTO = #const ENOCOMPATPROTO

_ENOTCONN :: CInt
_ENOTCONN = #const ENOTCONN

_ENOTSOCK :: CInt
_ENOTSOCK = #const ENOTSOCK

_ENOTSUP :: CInt
_ENOTSUP = #const ENOTSUP

_EPROTONOSUPPORT :: CInt
_EPROTONOSUPPORT = #const EPROTONOSUPPORT

_ETERM :: CInt
_ETERM = #const ETERM

_ETIMEDOUT :: CInt
_ETIMEDOUT = #const ETIMEDOUT

------------------------------------------------------------------------------------------------------------------------
-- Context options

_ZMQ_IO_THREADS :: CInt
_ZMQ_IO_THREADS = #const ZMQ_IO_THREADS

_ZMQ_MAX_MSGSZ :: CInt
_ZMQ_MAX_MSGSZ = #const ZMQ_MAX_MSGSZ

_ZMQ_MAX_SOCKETS :: CInt
_ZMQ_MAX_SOCKETS = #const ZMQ_MAX_SOCKETS

_ZMQ_MSG_T_SIZE :: CInt
_ZMQ_MSG_T_SIZE = #const ZMQ_MSG_T_SIZE

_ZMQ_SOCKET_LIMIT :: CInt
_ZMQ_SOCKET_LIMIT = #const ZMQ_SOCKET_LIMIT

_ZMQ_THREAD_AFFINITY_CPU_ADD :: CInt
_ZMQ_THREAD_AFFINITY_CPU_ADD = #const ZMQ_THREAD_AFFINITY_CPU_ADD

_ZMQ_THREAD_AFFINITY_CPU_REMOVE :: CInt
_ZMQ_THREAD_AFFINITY_CPU_REMOVE = #const ZMQ_THREAD_AFFINITY_CPU_REMOVE

_ZMQ_THREAD_NAME_PREFIX :: CInt
_ZMQ_THREAD_NAME_PREFIX = #const ZMQ_THREAD_NAME_PREFIX

_ZMQ_THREAD_PRIORITY :: CInt
_ZMQ_THREAD_PRIORITY = #const ZMQ_THREAD_PRIORITY

_ZMQ_THREAD_SCHED_POLICY :: CInt
_ZMQ_THREAD_SCHED_POLICY = #const ZMQ_THREAD_SCHED_POLICY

------------------------------------------------------------------------------------------------------------------------
-- Default for new contexts

_ZMQ_IO_THREADS_DFLT :: CInt
_ZMQ_IO_THREADS_DFLT = #const ZMQ_IO_THREADS_DFLT

_ZMQ_MAX_SOCKETS_DFLT :: CInt
_ZMQ_MAX_SOCKETS_DFLT = #const ZMQ_MAX_SOCKETS_DFLT

_ZMQ_THREAD_PRIORITY_DFLT :: CInt
_ZMQ_THREAD_PRIORITY_DFLT = #const ZMQ_THREAD_PRIORITY_DFLT

_ZMQ_THREAD_SCHED_POLICY_DFLT :: CInt
_ZMQ_THREAD_SCHED_POLICY_DFLT = #const ZMQ_THREAD_SCHED_POLICY_DFLT

------------------------------------------------------------------------------------------------------------------------
-- Socket types

_ZMQ_DEALER :: CInt
_ZMQ_DEALER = #const ZMQ_DEALER

_ZMQ_PAIR :: CInt
_ZMQ_PAIR = #const ZMQ_PAIR

_ZMQ_PUB :: CInt
_ZMQ_PUB = #const ZMQ_PUB

_ZMQ_PULL :: CInt
_ZMQ_PULL = #const ZMQ_PULL

_ZMQ_PUSH :: CInt
_ZMQ_PUSH = #const ZMQ_PUSH

_ZMQ_REP :: CInt
_ZMQ_REP = #const ZMQ_REP

_ZMQ_REQ :: CInt
_ZMQ_REQ = #const ZMQ_REQ

_ZMQ_ROUTER :: CInt
_ZMQ_ROUTER = #const ZMQ_ROUTER

_ZMQ_STREAM :: CInt
_ZMQ_STREAM = #const ZMQ_STREAM

_ZMQ_SUB :: CInt
_ZMQ_SUB = #const ZMQ_SUB

_ZMQ_XPUB :: CInt
_ZMQ_XPUB = #const ZMQ_XPUB

_ZMQ_XSUB :: CInt
_ZMQ_XSUB = #const ZMQ_XSUB

------------------------------------------------------------------------------------------------------------------------
-- Socket options

_ZMQ_AFFINITY :: CInt
_ZMQ_AFFINITY = #const ZMQ_AFFINITY

_ZMQ_BACKLOG :: CInt
_ZMQ_BACKLOG = #const ZMQ_BACKLOG

_ZMQ_BINDTODEVICE :: CInt
_ZMQ_BINDTODEVICE = #const ZMQ_BINDTODEVICE

_ZMQ_BLOCKY :: CInt
_ZMQ_BLOCKY = #const ZMQ_BLOCKY

_ZMQ_CONFLATE :: CInt
_ZMQ_CONFLATE = #const ZMQ_CONFLATE

_ZMQ_CONNECT_ROUTING_ID :: CInt
_ZMQ_CONNECT_ROUTING_ID = #const ZMQ_CONNECT_ROUTING_ID

_ZMQ_CONNECT_TIMEOUT :: CInt
_ZMQ_CONNECT_TIMEOUT = #const ZMQ_CONNECT_TIMEOUT

_ZMQ_CURVE_PUBLICKEY :: CInt
_ZMQ_CURVE_PUBLICKEY = #const ZMQ_CURVE_PUBLICKEY

_ZMQ_CURVE_SECRETKEY :: CInt
_ZMQ_CURVE_SECRETKEY = #const ZMQ_CURVE_SECRETKEY

_ZMQ_CURVE_SERVER :: CInt
_ZMQ_CURVE_SERVER = #const ZMQ_CURVE_SERVER

_ZMQ_CURVE_SERVERKEY :: CInt
_ZMQ_CURVE_SERVERKEY = #const ZMQ_CURVE_SERVERKEY

_ZMQ_EVENTS :: CInt
_ZMQ_EVENTS = #const ZMQ_EVENTS

_ZMQ_FD :: CInt
_ZMQ_FD = #const ZMQ_FD

_ZMQ_GSSAPI_PLAINTEXT :: CInt
_ZMQ_GSSAPI_PLAINTEXT = #const ZMQ_GSSAPI_PLAINTEXT

_ZMQ_GSSAPI_PRINCIPAL :: CInt
_ZMQ_GSSAPI_PRINCIPAL = #const ZMQ_GSSAPI_PRINCIPAL

_ZMQ_GSSAPI_PRINCIPAL_NAMETYPE :: CInt
_ZMQ_GSSAPI_PRINCIPAL_NAMETYPE = #const ZMQ_GSSAPI_PRINCIPAL_NAMETYPE

_ZMQ_GSSAPI_SERVER :: CInt
_ZMQ_GSSAPI_SERVER = #const ZMQ_GSSAPI_SERVER

_ZMQ_GSSAPI_SERVICE_PRINCIPAL :: CInt
_ZMQ_GSSAPI_SERVICE_PRINCIPAL = #const ZMQ_GSSAPI_SERVICE_PRINCIPAL

_ZMQ_GSSAPI_SERVICE_PRINCIPAL_NAMETYPE :: CInt
_ZMQ_GSSAPI_SERVICE_PRINCIPAL_NAMETYPE = #const ZMQ_GSSAPI_SERVICE_PRINCIPAL_NAMETYPE

_ZMQ_HANDSHAKE_IVL :: CInt
_ZMQ_HANDSHAKE_IVL = #const ZMQ_HANDSHAKE_IVL

_ZMQ_HEARTBEAT_IVL :: CInt
_ZMQ_HEARTBEAT_IVL = #const ZMQ_HEARTBEAT_IVL

_ZMQ_HEARTBEAT_TIMEOUT :: CInt
_ZMQ_HEARTBEAT_TIMEOUT = #const ZMQ_HEARTBEAT_TIMEOUT

_ZMQ_HEARTBEAT_TTL :: CInt
_ZMQ_HEARTBEAT_TTL = #const ZMQ_HEARTBEAT_TTL

_ZMQ_IMMEDIATE :: CInt
_ZMQ_IMMEDIATE = #const ZMQ_IMMEDIATE

_ZMQ_INVERT_MATCHING :: CInt
_ZMQ_INVERT_MATCHING = #const ZMQ_INVERT_MATCHING

_ZMQ_IPV6 :: CInt
_ZMQ_IPV6 = #const ZMQ_IPV6

_ZMQ_LAST_ENDPOINT :: CInt
_ZMQ_LAST_ENDPOINT = #const ZMQ_LAST_ENDPOINT

_ZMQ_LINGER :: CInt
_ZMQ_LINGER = #const ZMQ_LINGER

_ZMQ_MAXMSGSIZE :: CInt
_ZMQ_MAXMSGSIZE = #const ZMQ_MAXMSGSIZE

_ZMQ_MECHANISM :: CInt
_ZMQ_MECHANISM = #const ZMQ_MECHANISM

_ZMQ_MULTICAST_HOPS :: CInt
_ZMQ_MULTICAST_HOPS = #const ZMQ_MULTICAST_HOPS

_ZMQ_MULTICAST_MAXTPDU :: CInt
_ZMQ_MULTICAST_MAXTPDU = #const ZMQ_MULTICAST_MAXTPDU

_ZMQ_PLAIN_PASSWORD :: CInt
_ZMQ_PLAIN_PASSWORD = #const ZMQ_PLAIN_PASSWORD

_ZMQ_PLAIN_SERVER :: CInt
_ZMQ_PLAIN_SERVER = #const ZMQ_PLAIN_SERVER

_ZMQ_PLAIN_USERNAME :: CInt
_ZMQ_PLAIN_USERNAME = #const ZMQ_PLAIN_USERNAME

_ZMQ_PROBE_ROUTER :: CInt
_ZMQ_PROBE_ROUTER = #const ZMQ_PROBE_ROUTER

_ZMQ_RATE :: CInt
_ZMQ_RATE = #const ZMQ_RATE

_ZMQ_RCVBUF :: CInt
_ZMQ_RCVBUF = #const ZMQ_RCVBUF

_ZMQ_RCVHWM :: CInt
_ZMQ_RCVHWM = #const ZMQ_RCVHWM

_ZMQ_RCVMORE :: CInt
_ZMQ_RCVMORE = #const ZMQ_RCVMORE

_ZMQ_RCVTIMEO :: CInt
_ZMQ_RCVTIMEO = #const ZMQ_RCVTIMEO

_ZMQ_RECONNECT_IVL :: CInt
_ZMQ_RECONNECT_IVL = #const ZMQ_RECONNECT_IVL

_ZMQ_RECONNECT_IVL_MAX :: CInt
_ZMQ_RECONNECT_IVL_MAX = #const ZMQ_RECONNECT_IVL_MAX

_ZMQ_RECOVERY_IVL :: CInt
_ZMQ_RECOVERY_IVL = #const ZMQ_RECOVERY_IVL

_ZMQ_REQ_CORRELATE :: CInt
_ZMQ_REQ_CORRELATE = #const ZMQ_REQ_CORRELATE

_ZMQ_REQ_RELAXED :: CInt
_ZMQ_REQ_RELAXED = #const ZMQ_REQ_RELAXED

_ZMQ_ROUTER_HANDOVER :: CInt
_ZMQ_ROUTER_HANDOVER = #const ZMQ_ROUTER_HANDOVER

_ZMQ_ROUTER_MANDATORY :: CInt
_ZMQ_ROUTER_MANDATORY = #const ZMQ_ROUTER_MANDATORY

_ZMQ_ROUTER_RAW :: CInt
_ZMQ_ROUTER_RAW = #const ZMQ_ROUTER_RAW

_ZMQ_ROUTING_ID :: CInt
_ZMQ_ROUTING_ID = #const ZMQ_ROUTING_ID

_ZMQ_SNDBUF :: CInt
_ZMQ_SNDBUF = #const ZMQ_SNDBUF

_ZMQ_SNDHWM :: CInt
_ZMQ_SNDHWM = #const ZMQ_SNDHWM

_ZMQ_SNDTIMEO :: CInt
_ZMQ_SNDTIMEO = #const ZMQ_SNDTIMEO

_ZMQ_SOCKS_PROXY :: CInt
_ZMQ_SOCKS_PROXY = #const ZMQ_SOCKS_PROXY

_ZMQ_STREAM_NOTIFY :: CInt
_ZMQ_STREAM_NOTIFY = #const ZMQ_STREAM_NOTIFY

_ZMQ_SUBSCRIBE :: CInt
_ZMQ_SUBSCRIBE = #const ZMQ_SUBSCRIBE

_ZMQ_TCP_KEEPALIVE :: CInt
_ZMQ_TCP_KEEPALIVE = #const ZMQ_TCP_KEEPALIVE

_ZMQ_TCP_KEEPALIVE_CNT :: CInt
_ZMQ_TCP_KEEPALIVE_CNT = #const ZMQ_TCP_KEEPALIVE_CNT

_ZMQ_TCP_KEEPALIVE_IDLE :: CInt
_ZMQ_TCP_KEEPALIVE_IDLE = #const ZMQ_TCP_KEEPALIVE_IDLE

_ZMQ_TCP_KEEPALIVE_INTVL :: CInt
_ZMQ_TCP_KEEPALIVE_INTVL = #const ZMQ_TCP_KEEPALIVE_INTVL

_ZMQ_TCP_MAXRT :: CInt
_ZMQ_TCP_MAXRT = #const ZMQ_TCP_MAXRT

_ZMQ_THREAD_SAFE :: CInt
_ZMQ_THREAD_SAFE = #const ZMQ_THREAD_SAFE

_ZMQ_TOS :: CInt
_ZMQ_TOS = #const ZMQ_TOS

_ZMQ_TYPE :: CInt
_ZMQ_TYPE = #const ZMQ_TYPE

_ZMQ_UNSUBSCRIBE :: CInt
_ZMQ_UNSUBSCRIBE = #const ZMQ_UNSUBSCRIBE

_ZMQ_USE_FD :: CInt
_ZMQ_USE_FD = #const ZMQ_USE_FD

_ZMQ_VMCI_BUFFER_MAX_SIZE :: CInt
_ZMQ_VMCI_BUFFER_MAX_SIZE = #const ZMQ_VMCI_BUFFER_MAX_SIZE

_ZMQ_VMCI_BUFFER_MIN_SIZE :: CInt
_ZMQ_VMCI_BUFFER_MIN_SIZE = #const ZMQ_VMCI_BUFFER_MIN_SIZE

_ZMQ_VMCI_BUFFER_SIZE :: CInt
_ZMQ_VMCI_BUFFER_SIZE = #const ZMQ_VMCI_BUFFER_SIZE

_ZMQ_VMCI_CONNECT_TIMEOUT :: CInt
_ZMQ_VMCI_CONNECT_TIMEOUT = #const ZMQ_VMCI_CONNECT_TIMEOUT

_ZMQ_XPUB_MANUAL :: CInt
_ZMQ_XPUB_MANUAL = #const ZMQ_XPUB_MANUAL

_ZMQ_XPUB_NODROP :: CInt
_ZMQ_XPUB_NODROP = #const ZMQ_XPUB_NODROP

_ZMQ_XPUB_VERBOSE :: CInt
_ZMQ_XPUB_VERBOSE = #const ZMQ_XPUB_VERBOSE

_ZMQ_XPUB_VERBOSER :: CInt
_ZMQ_XPUB_VERBOSER = #const ZMQ_XPUB_VERBOSER

_ZMQ_XPUB_WELCOME_MSG :: CInt
_ZMQ_XPUB_WELCOME_MSG = #const ZMQ_XPUB_WELCOME_MSG

_ZMQ_ZAP_DOMAIN :: CInt
_ZMQ_ZAP_DOMAIN = #const ZMQ_ZAP_DOMAIN

------------------------------------------------------------------------------------------------------------------------
-- Message options

_ZMQ_MORE :: CInt
_ZMQ_MORE = #const ZMQ_MORE

_ZMQ_SHARED :: CInt
_ZMQ_SHARED = #const ZMQ_SHARED

------------------------------------------------------------------------------------------------------------------------
-- Send/recv options

_ZMQ_DONTWAIT :: CInt
_ZMQ_DONTWAIT = #const ZMQ_DONTWAIT

_ZMQ_SNDMORE :: CInt
_ZMQ_SNDMORE = #const ZMQ_SNDMORE

------------------------------------------------------------------------------------------------------------------------
-- Security mechanisms

_ZMQ_CURVE :: CInt
_ZMQ_CURVE = #const ZMQ_CURVE

_ZMQ_GSSAPI :: CInt
_ZMQ_GSSAPI = #const ZMQ_GSSAPI

_ZMQ_NULL :: CInt
_ZMQ_NULL = #const ZMQ_NULL

_ZMQ_PLAIN :: CInt
_ZMQ_PLAIN = #const ZMQ_PLAIN

------------------------------------------------------------------------------------------------------------------------
-- RADIO-DISH protocol

_ZMQ_GROUP_MAX_LENGTH :: CInt
_ZMQ_GROUP_MAX_LENGTH = #const ZMQ_GROUP_MAX_LENGTH

------------------------------------------------------------------------------------------------------------------------
-- GSSAPI principal name types

_ZMQ_GSSAPI_NT_HOSTBASED :: CInt
_ZMQ_GSSAPI_NT_HOSTBASED = #const ZMQ_GSSAPI_NT_HOSTBASED

_ZMQ_GSSAPI_NT_KRB5_PRINCIPAL :: CInt
_ZMQ_GSSAPI_NT_KRB5_PRINCIPAL = #const ZMQ_GSSAPI_NT_KRB5_PRINCIPAL

_ZMQ_GSSAPI_NT_USER_NAME :: CInt
_ZMQ_GSSAPI_NT_USER_NAME = #const ZMQ_GSSAPI_NT_USER_NAME

------------------------------------------------------------------------------------------------------------------------
-- Socket transport events (TCP, IPC and TIPC only)

_ZMQ_EVENT_ACCEPTED :: CInt
_ZMQ_EVENT_ACCEPTED = #const ZMQ_EVENT_ACCEPTED

_ZMQ_EVENT_ACCEPT_FAILED :: CInt
_ZMQ_EVENT_ACCEPT_FAILED = #const ZMQ_EVENT_ACCEPT_FAILED

_ZMQ_EVENT_ALL :: CInt
_ZMQ_EVENT_ALL = #const ZMQ_EVENT_ALL

_ZMQ_EVENT_BIND_FAILED :: CInt
_ZMQ_EVENT_BIND_FAILED = #const ZMQ_EVENT_BIND_FAILED

_ZMQ_EVENT_CLOSED :: CInt
_ZMQ_EVENT_CLOSED = #const ZMQ_EVENT_CLOSED

_ZMQ_EVENT_CLOSE_FAILED :: CInt
_ZMQ_EVENT_CLOSE_FAILED = #const ZMQ_EVENT_CLOSE_FAILED

_ZMQ_EVENT_CONNECTED :: CInt
_ZMQ_EVENT_CONNECTED = #const ZMQ_EVENT_CONNECTED

_ZMQ_EVENT_CONNECT_DELAYED :: CInt
_ZMQ_EVENT_CONNECT_DELAYED = #const ZMQ_EVENT_CONNECT_DELAYED

_ZMQ_EVENT_CONNECT_RETRIED :: CInt
_ZMQ_EVENT_CONNECT_RETRIED = #const ZMQ_EVENT_CONNECT_RETRIED

_ZMQ_EVENT_DISCONNECTED :: CInt
_ZMQ_EVENT_DISCONNECTED = #const ZMQ_EVENT_DISCONNECTED

_ZMQ_EVENT_HANDSHAKE_FAILED_AUTH :: CInt
_ZMQ_EVENT_HANDSHAKE_FAILED_AUTH = #const ZMQ_EVENT_HANDSHAKE_FAILED_AUTH

_ZMQ_EVENT_HANDSHAKE_FAILED_NO_DETAIL :: CInt
_ZMQ_EVENT_HANDSHAKE_FAILED_NO_DETAIL = #const ZMQ_EVENT_HANDSHAKE_FAILED_NO_DETAIL

_ZMQ_EVENT_HANDSHAKE_FAILED_PROTOCOL :: CInt
_ZMQ_EVENT_HANDSHAKE_FAILED_PROTOCOL = #const ZMQ_EVENT_HANDSHAKE_FAILED_PROTOCOL

_ZMQ_EVENT_HANDSHAKE_SUCCEEDED :: CInt
_ZMQ_EVENT_HANDSHAKE_SUCCEEDED = #const ZMQ_EVENT_HANDSHAKE_SUCCEEDED

_ZMQ_EVENT_LISTENING :: CInt
_ZMQ_EVENT_LISTENING = #const ZMQ_EVENT_LISTENING

_ZMQ_EVENT_MONITOR_STOPPED :: CInt
_ZMQ_EVENT_MONITOR_STOPPED = #const ZMQ_EVENT_MONITOR_STOPPED

------------------------------------------------------------------------------------------------------------------------
-- Protocol errors

_ZMQ_PROTOCOL_ERROR_WS_UNSPECIFIED :: CInt
_ZMQ_PROTOCOL_ERROR_WS_UNSPECIFIED = #const ZMQ_PROTOCOL_ERROR_WS_UNSPECIFIED

_ZMQ_PROTOCOL_ERROR_ZAP_BAD_REQUEST_ID :: CInt
_ZMQ_PROTOCOL_ERROR_ZAP_BAD_REQUEST_ID = #const ZMQ_PROTOCOL_ERROR_ZAP_BAD_REQUEST_ID

_ZMQ_PROTOCOL_ERROR_ZAP_BAD_VERSION :: CInt
_ZMQ_PROTOCOL_ERROR_ZAP_BAD_VERSION = #const ZMQ_PROTOCOL_ERROR_ZAP_BAD_VERSION

_ZMQ_PROTOCOL_ERROR_ZAP_INVALID_METADATA :: CInt
_ZMQ_PROTOCOL_ERROR_ZAP_INVALID_METADATA = #const ZMQ_PROTOCOL_ERROR_ZAP_INVALID_METADATA

_ZMQ_PROTOCOL_ERROR_ZAP_INVALID_STATUS_CODE :: CInt
_ZMQ_PROTOCOL_ERROR_ZAP_INVALID_STATUS_CODE = #const ZMQ_PROTOCOL_ERROR_ZAP_INVALID_STATUS_CODE

_ZMQ_PROTOCOL_ERROR_ZAP_MALFORMED_REPLY :: CInt
_ZMQ_PROTOCOL_ERROR_ZAP_MALFORMED_REPLY = #const ZMQ_PROTOCOL_ERROR_ZAP_MALFORMED_REPLY

_ZMQ_PROTOCOL_ERROR_ZAP_UNSPECIFIED :: CInt
_ZMQ_PROTOCOL_ERROR_ZAP_UNSPECIFIED = #const ZMQ_PROTOCOL_ERROR_ZAP_UNSPECIFIED

_ZMQ_PROTOCOL_ERROR_ZMTP_CRYPTOGRAPHIC :: CInt
_ZMQ_PROTOCOL_ERROR_ZMTP_CRYPTOGRAPHIC = #const ZMQ_PROTOCOL_ERROR_ZMTP_CRYPTOGRAPHIC

_ZMQ_PROTOCOL_ERROR_ZMTP_INVALID_METADATA :: CInt
_ZMQ_PROTOCOL_ERROR_ZMTP_INVALID_METADATA = #const ZMQ_PROTOCOL_ERROR_ZMTP_INVALID_METADATA

_ZMQ_PROTOCOL_ERROR_ZMTP_INVALID_SEQUENCE :: CInt
_ZMQ_PROTOCOL_ERROR_ZMTP_INVALID_SEQUENCE = #const ZMQ_PROTOCOL_ERROR_ZMTP_INVALID_SEQUENCE

_ZMQ_PROTOCOL_ERROR_ZMTP_KEY_EXCHANGE :: CInt
_ZMQ_PROTOCOL_ERROR_ZMTP_KEY_EXCHANGE = #const ZMQ_PROTOCOL_ERROR_ZMTP_KEY_EXCHANGE

_ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_ERROR :: CInt
_ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_ERROR = #const ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_ERROR

_ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_HELLO :: CInt
_ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_HELLO = #const ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_HELLO

_ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_INITIATE :: CInt
_ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_INITIATE = #const ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_INITIATE

_ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_MESSAGE :: CInt
_ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_MESSAGE = #const ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_MESSAGE

_ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_READY :: CInt
_ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_READY = #const ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_READY

_ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_UNSPECIFIED :: CInt
_ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_UNSPECIFIED = #const ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_UNSPECIFIED

_ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_WELCOME :: CInt
_ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_WELCOME = #const ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_WELCOME

_ZMQ_PROTOCOL_ERROR_ZMTP_MECHANISM_MISMATCH :: CInt
_ZMQ_PROTOCOL_ERROR_ZMTP_MECHANISM_MISMATCH = #const ZMQ_PROTOCOL_ERROR_ZMTP_MECHANISM_MISMATCH

_ZMQ_PROTOCOL_ERROR_ZMTP_UNEXPECTED_COMMAND :: CInt
_ZMQ_PROTOCOL_ERROR_ZMTP_UNEXPECTED_COMMAND = #const ZMQ_PROTOCOL_ERROR_ZMTP_UNEXPECTED_COMMAND

_ZMQ_PROTOCOL_ERROR_ZMTP_UNSPECIFIED :: CInt
_ZMQ_PROTOCOL_ERROR_ZMTP_UNSPECIFIED = #const ZMQ_PROTOCOL_ERROR_ZMTP_UNSPECIFIED

------------------------------------------------------------------------------------------------------------------------
-- I/O multiplexint

_ZMQ_POLLIN :: CShort
_ZMQ_POLLIN = #const ZMQ_POLLIN

_ZMQ_POLLOUT :: CShort
_ZMQ_POLLOUT = #const ZMQ_POLLOUT

_ZMQ_POLLERR :: CShort
_ZMQ_POLLERR = #const ZMQ_POLLERR

_ZMQ_POLLPRI :: CShort
_ZMQ_POLLPRI = #const ZMQ_POLLPRI

------------------------------------------------------------------------------------------------------------------------
-- Probe library capabilities

_ZMQ_HAS_CAPABILITIES :: CInt
_ZMQ_HAS_CAPABILITIES = #const ZMQ_HAS_CAPABILITIES
