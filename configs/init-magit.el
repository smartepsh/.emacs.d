(use-package magit
  :commands (magit-status)
  :general
  (my-leader-def
  "gs" 'magit-status
  ))

(use-package evil-magit
  :after magit)

(provide 'init-magit)
