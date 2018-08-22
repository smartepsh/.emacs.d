(use-package server
  :defer t
  :init
  (setq server-name "kenton")
  (add-hook 'after-init-hook #'server-start))

(provide 'init-server)
