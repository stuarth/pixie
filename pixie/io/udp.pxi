(ns pixie.io.udp
  (:require [pixie.uv :as uv]
            [pixie.stacklets :as st]
            [pixie.ffi :as ffi]
            [pixie.io.ip :as ip]))

(defn udp-socket
  "udp-socket (uv_udp_t) on ip & port"
  ([] (udp-socket "0.0.0.0" 0 0))
  ([ip port] (udp-socket ip port 0))
  ([ip port flags]
   (let [socket (uv/uv_udp_t)
         addr (ip/ip4-sock-addr ip port)]
     (uv/uv_udp_init (uv/uv_default_loop) socket)
     (uv/uv_udp_bind socket addr flags)
     socket)))

(deftype UDPServer [socket]
  IDisposable
  (-dispose! [this]
    (uv/throw-on-error (uv/uv_udp_recv_stop socket))
    (dispose! socket)))

(defn udp-server
  "Creates a UDP server on the given ip (as a string) and port (as an integer). Returns a UDPServer that can be
  shutdown with dispose!. on-connect is a function that will be passed the number of bytes read, the bufffer
  containing those bytes, the sender address and any flags"
  [ip port on-connect]
  (let [socket (udp-socket ip port)
        server (->UDPServer socket)]
    (uv/uv_udp_recv_start
     socket
     (ffi/ffi-prep-callback
      uv/uv_alloc_cb
      (fn [handle suggested-size uv-buf]
        (let [uv-buf (ffi/cast uv-buf uv/uv_buf_t)]
          (ffi/set! uv-buf :base (buffer suggested-size))
          (ffi/set! uv-buf :len suggested-size))))

     (ffi/ffi-prep-callback
      uv/uv_udp_recv_cb
      (fn [handle num-bytes-read buf sender-addr flags]
        (uv/throw-on-error num-bytes-read)

        (let [buf (ffi/cast buf uv/uv_buf_t)
              sender-addr
              (when sender-addr
                (ffi/cast sender-addr uv/sockaddr_in))]
          (st/spawn-from-non-stacklet
           #(on-connect num-bytes-read buf sender-addr flags))))))
    server))

(defn send-uv-buf
  "send content of uv-buf to ip & port via udp-socket"
  [udp-socket ip port uv-buf]
  (let [request (uv/uv_udp_send_t)
        dest-addr (ip/ip4-sock-addr ip port)]
    (-> (uv/uv_udp_send
         request udp-socket uv-buf 1 dest-addr
         (ffi/ffi-prep-callback
          uv/uv_udp_send_cb
          (fn [f status]
            (dispose! dest-addr)
            (dispose! uv-buf)
            (dispose! request)
            (uv/throw-on-error status))))
        uv/throw-on-error)))

(defn send
  "send msg to ip & port via udp-socket"
  ([ip port msg]
   (send (udp-socket) ip port msg))
  ([udp-socket ip port msg]
   (let [uv-buf (uv/uv_buf_t)]
     (ffi/set! uv-buf :base msg)
     (ffi/set! uv-buf :len (count msg))
     (send-uv-buf udp-socket ip port uv-buf))))
