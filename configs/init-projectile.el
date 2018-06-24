(use-package projectile
             :delight
             :commands (projectile-find-file)
	     :general
	     (my-leader-def
	       "pf" 'projectile-find-file)
             )

(provide 'init-projectile)
