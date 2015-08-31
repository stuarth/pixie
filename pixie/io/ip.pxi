(ns pixie.io.ip
  (:require [pixie.uv :as uv]))

(defn ip4-sock-addr
  [ip port]
  (assert (string? ip) "Ip should be a string")
  (assert (integer? port) "Port should be a int")
  
  (let [addr (uv/sockaddr_in)]
    (uv/throw-on-error (uv/uv_ip4_addr ip port addr))
    addr))
