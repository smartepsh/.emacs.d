(use-package projectile
  :commands (projectile-dired)
  :general
  (common-leader
    "p" '(:ignore t :which-key "projectile")
    "pd" 'projectile-dired))

(use-package counsel-projectile
  :quelpa (counsel-projectile :fetcher github :repo "smartepsh/counsel-projectile")
  :commands (counsel-projectile-find-file)
  :general
  (common-leader
    "p" '(:ignore t :which-key "projectile")
    "pf" 'counsel-projectile-find-file))

(provide 'init-projectile)
