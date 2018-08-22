(use-package magit
  :commands (magit-status magit-blame)
  :general
  (clear-spc
   :keymaps
   '(magit-mode-map
     magit-status-mode-map
     magit-diff-mode-map
     magit-process-mode-map
     magit-blame-read-only-mode-map
     magit-log-mode-map
     git-rebase-mode-map))
  (common-leader
  "gs" 'magit-status
  "gb" 'magit-blame
  ))

(use-package evil-magit
  :after (magit))

(provide 'init-magit)
