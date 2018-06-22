(use-package server
  :init
  (setq server-name "kenton")
  (server-mode 1)
  :config
  (unless (server-running-p)
    (server-start)))

(provide 'init-server)
