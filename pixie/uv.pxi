(ns pixie.uv
  (:require [pixie.ffi :as ffi]
            [pixie.ffi-infer :as f]))

(f/with-config  {:library "uv"
                :includes ["uv.h"]}
  (f/defconst UV_RUN_DEFAULT)
  (f/defconst UV_RUN_ONCE)
  (f/defconst UV_RUN_NOWAIT)

  (f/defcfn uv_close)
  (f/defccallback uv_close_cb)


  (f/defcstruct uv_loop_t [])

  (f/defcfn uv_loop_init)
  (f/defcfn uv_loop_close)
  (f/defcfn uv_default_loop)

  (f/defcfn uv_run)
  (f/defcfn uv_loop_alive)
  (f/defcfn uv_unref)
  (f/defcfn uv_ref)
  (f/defcfn uv_stop)
  (f/defcfn uv_loop_size)
  (f/defcfn uv_backend_fd)
  (f/defcfn uv_backend_timeout)
  (f/defcfn uv_now)
  (f/defcfn uv_update_time)
  (f/defcfn uv_walk)

  (f/defccallback uv_alloc_cb)

  (f/defcstruct uv_connect_t [:handle])
  (f/defcstruct uv_stream_t [])

  (f/defcfn uv_read_start)
  (f/defccallback uv_read_cb)

  (f/defcfn uv_write)
  (f/defcstruct uv_write_t [])
  (f/defccallback uv_write_cb)


  ;; Timer

  (f/defcstruct uv_timer_t [])
  (f/defccallback uv_timer_cb)
  (f/defcfn uv_timer_init)
  (f/defcfn uv_timer_start)
  (f/defcfn uv_timer_stop)
  (f/defcfn uv_timer_again)
  (f/defcfn uv_timer_set_repeat)
  (f/defcfn uv_timer_get_repeat)

  ;; Time
  (f/defcfn uv_hrtime)


  ;; Filesystem

  (f/defcstruct uv_fs_t [:loop
                         :fs_type
                         :path
                         :result
                         :ptr
                         :statbuf.st_size
                         :statbuf.st_mode])
  (f/defcstruct uv_timespec_t [:tv_sec
                               :tv_nsec])
  (f/defcstruct uv_stat_t [:st_dev
                           :st_mode
                           :st_nlink
                           :st_uid
                           :st_gid
                           :st_rdev
                           :st_ino
                           :st_size
                           :st_blksize
                           :st_blocks
                           :st_flags
                           :st_gen
                           :st_atim.tv_sec
                           :st_atim.tv_nsec
                           :st_mtim.tv_sec
                           :st_mtim.tv_nsec
                           :st_ctim.tv_sec
                           :st_ctim.tv_nsec
                           :st_birthtim.tv_sec
                           :st_birthtim.tv_nsec])

    (f/defconst UV_FS_UNKNOWN)
    (f/defconst UV_FS_CUSTOM)
    (f/defconst UV_FS_OPEN)
    (f/defconst UV_FS_CLOSE)
    (f/defconst UV_FS_READ)
    (f/defconst UV_FS_WRITE)
    (f/defconst UV_FS_SENDFILE)
    (f/defconst UV_FS_STAT)
    (f/defconst UV_FS_LSTAT)
    (f/defconst UV_FS_FSTAT)
    (f/defconst UV_FS_FTRUNCATE)
    (f/defconst UV_FS_UTIME)
    (f/defconst UV_FS_FUTIME)
    (f/defconst UV_FS_ACCESS)
    (f/defconst UV_FS_CHMOD)
    (f/defconst UV_FS_FCHMOD)
    (f/defconst UV_FS_FSYNC)
    (f/defconst UV_FS_FDATASYNC)
    (f/defconst UV_FS_UNLINK)
    (f/defconst UV_FS_RMDIR)
    (f/defconst UV_FS_MKDIR)
    (f/defconst UV_FS_MKDTEMP)
    (f/defconst UV_FS_RENAME)
    (f/defconst UV_FS_SCANDIR)
    (f/defconst UV_FS_LINK)
    (f/defconst UV_FS_SYMLINK)
    (f/defconst UV_FS_READLINK)
    (f/defconst UV_FS_CHOWN)
    (f/defconst UV_FS_FCHOWN)

    (f/defconst UV_DIRENT_UNKNOWN)
    (f/defconst UV_DIRENT_FILE)
    (f/defconst UV_DIRENT_DIR)
    (f/defconst UV_DIRENT_LINK)
    (f/defconst UV_DIRENT_FIFO)
    (f/defconst UV_DIRENT_SOCKET)
    (f/defconst UV_DIRENT_CHAR)
    (f/defconst UV_DIRENT_BLOCK)

    (f/defconst UV_EOF)

    (f/defcstruct uv_dirent_t [:name
                               :type])

    (f/defcstruct uv_buf_t [:base :len])

    (f/defcfn uv_fs_req_cleanup)
    (f/defcfn uv_fs_close)
    (f/defcfn uv_fs_open)

    (f/defccallback uv_fs_cb)

    (f/defcfn uv_fs_unlink)
    (f/defcfn uv_fs_write)
    (f/defcfn uv_fs_read)
    (f/defcfn uv_fs_mkdir)
    (f/defcfn uv_fs_mkdtemp)
    (f/defcfn uv_fs_rmdir)
    (f/defcfn uv_fs_scandir)
    (f/defcfn uv_fs_scandir_next)
    (f/defcfn uv_fs_stat)
    (f/defcfn uv_fs_fstat)
    (f/defcfn uv_fs_lstat)
    (f/defcfn uv_fs_rename)
    (f/defcfn uv_fs_fsync)
    (f/defcfn uv_fs_fdatasync)
    (f/defcfn uv_fs_ftruncate)
    (f/defcfn uv_fs_sendfile)
    (f/defcfn uv_fs_access)
    (f/defcfn uv_fs_chmod)
    (f/defcfn uv_fs_fchmod)
    (f/defcfn uv_fs_utime)
    (f/defcfn uv_fs_futime)
    (f/defcfn uv_fs_link)
    (f/defcfn uv_fs_symlink)
    (f/defcfn uv_fs_readlink)
    (f/defcfn uv_fs_chown)
    (f/defcfn uv_fs_fchown)

    (f/defconst O_RDONLY)
    (f/defconst O_WRONLY)
    (f/defconst O_RDWR)

    (f/defconst O_APPEND)
    (f/defconst O_ASYNC)
    (f/defconst O_CREAT)

    (f/defconst S_IRUSR)
    (f/defconst S_IRWXU)
    (f/defconst S_IWUSR)


    ; ERRNO
    (f/defconst UV_E2BIG)
    (f/defconst UV_EACCES)

    (f/defcfn uv_err_name)

    ; async
    (f/defcstruct uv_async_t [])
    (f/defccallback uv_async_cb)
    (f/defcfn uv_async_init)
    (f/defcfn uv_async_send)

    ; TTY
    (f/defcfn uv_tty_init)
    (f/defconst UV_TTY_MODE_NORMAL)
    (f/defcfn uv_guess_handle)
    ;(f/defcfn uv_tty_set_mode)
    (f/defcstruct uv_tty_t [])
    (f/defconst UV_TTY)


    ; TCP Networking
    (f/defcstruct uv_tcp_t [])
    (f/defc-raw-struct sockaddr_in [])
    (f/defcfn uv_tcp_init)
    (f/defcfn uv_ip4_addr)
    (f/defcfn uv_tcp_bind)
    (f/defcfn uv_listen)
    (f/defcfn uv_accept)
    (f/defcfn uv_ip4_name)
    (f/defcfn uv_tcp_connect)
    (f/defcfn uv_tcp_keepalive)
    (f/defcfn uv_read_start)
    (f/defcfn uv_read_stop)

    (f/defccallback uv_connection_cb)
    (f/defccallback uv_connect_cb)

    ; UDP Networking
    (f/defconst UV_UDP_REUSEADDR)
    (f/defcstruct uv_udp_t [])
    (f/defcstruct uv_udp_send_t [])
    (f/defcfn uv_udp_init)
    (f/defcfn uv_ip4_addr)
    (f/defcfn uv_udp_bind)
    (f/defcfn uv_udp_recv_start)
    (f/defcfn uv_udp_set_broadcast)
    (f/defcfn uv_udp_send)
    (f/defcfn uv_udp_recv_stop)
    (f/defccallback uv_udp_send_cb)
    (f/defccallback uv_udp_recv_cb)
    
    (f/defccallback uv_alloc_cb)
    (f/defccallback uv_read_cb))


(defn new-fs-buf [size]
  (let [b (buffer size)
        bt (uv_buf_t)]
    (pixie.ffi/set! bt :base b)
    (pixie.ffi/set! bt :len size)
    bt))


(defn throw-on-error [result]
  (if (neg? result)
    (throw [::UVException (str "UV Error: " (uv_err_name result))])
    result))

(defmacro defuvfsfn
  ([nm args return]
   (defuvfsfn nm (symbol (str "pixie.uv/uv_" (name nm))) args return))
  ([nm uv-fn args return]
  `(defn ~nm ~args
     (let [f (fn [k#]
               (let [cb# (atom nil)]
                 (reset! cb# (ffi/ffi-prep-callback uv_fs_cb
                                                (fn [req#]
                                                  (try
                                                    (pixie.stacklets/run-and-process k# (~return (pixie.ffi/cast req# uv_fs_t)))
                                                    (uv_fs_req_cleanup req#)
                                                    (-dispose! @cb#)
                                                    (catch e (println e))))))
                 (~uv-fn
                  (uv_default_loop)
                  (uv_fs_t)
                  ~@args
                  @cb#)))]
       (pixie.stacklets/call-cc f)))))

(defn -prep-uv-buffer-fn [buf read-bytes]
  (ffi/ffi-prep-callback
   uv_alloc_cb
   (fn [handle suggested-size uv-buf]
     (try
       (let [casted (ffi/cast uv-buf uv_buf_t)]
         (ffi/set! casted :base buf)
         (ffi/set! casted :len (min suggested-size
                                    (buffer-capacity buf)
                                    read-bytes)))
       (catch ex (println ex))))))
