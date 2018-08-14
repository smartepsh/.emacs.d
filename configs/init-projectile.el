(use-package projectile
             :commands (projectile-find-file)
	     :general
	     (common-leader
	       "pf" 'projectile-find-file)
             )

(provide 'init-projectile)
