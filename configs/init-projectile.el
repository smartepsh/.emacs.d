(use-package projectile
  :commands (projectile-dired)
  :init
  (setq ;;projectile-sort-order 'recentf-active
	project-cache-file "~/.emacs.d/projectile.cache"
	project-known-projects-file "~/.emacs.d/projectile-bookmarks.eld"
        projectile-project-search-path '("~/kenton/")
	projectile-completion-system 'ivy)
  :config
  (projectile-mode t)
  (projectile-discover-projects-in-search-path)
  :general
  (common-leader
    "p" '(:ignore t :which-key "projectile")
    "pa" '(projectile-discover-projects-in-search-path :which-key "find-all-projects")
    "pc" 'projectile-kill-buffers
    "pd" 'projectile-dired
    "pI" 'projectile-invalidate-cache))

(use-package counsel-projectile
  :commands (counsel-projectile-find-file)
  :general
  (common-leader
    "p" '(:ignore t :which-key "projectile")
    "pf" 'counsel-projectile-find-file
    "pl" 'counsel-projectile-switch-project))

(provide 'init-projectile)
