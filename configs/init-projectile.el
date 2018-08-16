(use-package projectile
  :defer 2)

(use-package counsel-projectile
  :quelpa (counsel-projectile :fetcher github :repo "smartepsh/counsel-projectile")
  :defer 2
  :general
  (common-leader
  "pf" 'counsel-projectile-find-file)
  )

(provide 'init-projectile)
