(use-package projectile
  :defer t
  :commands (projectile-dired)
  :general
  (common-leader
    "pd" 'projectile-dired))

(use-package counsel-projectile
  :quelpa (counsel-projectile :fetcher github :repo "smartepsh/counsel-projectile")
  :commands (counsel-projectile-find-file)
  :general
  (common-leader
    "pf" 'counsel-projectile-find-file))

(provide 'init-projectile)
