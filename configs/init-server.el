(use-package server
  :defer t
  :init
  (setq server-name "kenton")
  (add-hook 'after-init-hook
	    (lambda ()
	      (unless (server-running-p)
		(server-start)))))

(provide 'init-server)
