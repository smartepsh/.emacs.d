(use-package magit
  :commands (magit-status)
  :general
  (clear-spc
   :keymaps
   `(magit-mode-map
     magit-status-mode-map
     magit-diff-mode-map
     magit-process-mode-map
     magit-blame-read-only-mode-map
     magit-log-mode-map
     git-rebase-mode-map))
  (my-leader-def
  "gs" 'magit-status
  ))

(use-package evil-magit
  :after magit)

(provide 'init-magit)
