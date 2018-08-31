(use-package projectile
  :commands (projectile-dired)
  :init
  (setq projectile-sort-order 'recentf
	project-cache-file "~/.emacs.d/projectile.cache"
	project-known-projects-file "~/.emacs.d/projectile-bookmarks.eld"
	projectile-completion-system 'ivy)
  :config
  (projectile-mode t)
  :general
  (common-leader
    "p" '(:ignore t :which-key "projectile")
    "pd" 'projectile-dired
    "pI" 'projectile-invalidate-cache))

(use-package counsel-projectile
  ;; fix bugs from my own repo, but it fixed now
  ;; :quelpa (counsel-projectile :fetcher github :repo "smartepsh/counsel-projectile")
  :commands (counsel-projectile-find-file)
  :general
  (common-leader
    "p" '(:ignore t :which-key "projectile")
    "pf" 'counsel-projectile-find-file
    "pl" 'counsel-projectile-switch-project))

(provide 'init-projectile)
