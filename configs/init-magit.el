(use-package magit
  :commands (magit-status)
  :general
  (common-leader-def
  "" nil
  "gs" 'magit-status
  ))

(use-package evil-magit
  :after magit)

(provide 'init-magit)
