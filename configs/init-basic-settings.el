(use-package popwin
  :config
  (popwin-mode 1))

(setq ring-bell-function 'ignore)
(fset #'yes-or-no-p #'y-or-n-p)

(provide 'init-basic-settings)
