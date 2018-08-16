(use-package popwin
  :config
  (popwin-mode 1))

(setq ring-bell-function 'ignore)
(fset #'yes-or-no-p #'y-or-n-p)

(setq-default ident-tabs-mode nil)
(setq tab-width 2)

(provide 'init-basic-settings)
