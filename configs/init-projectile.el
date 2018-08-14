(use-package projectile
  :defer t)

(use-package counsel-projectile
  :defer t
  :after counsel projectile
  :general
  (common-leader
  "pf" 'counsel-projectile-find-file
    )
  )

(provide 'init-projectile)
