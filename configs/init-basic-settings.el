(setq ring-bell-function 'ignore
      scroll-margin 0
      scroll-conservatively 1001
      scroll-preserve-screen-position t)

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(fset #'yes-or-no-p #'y-or-n-p)

(setq-default ident-tabs-mode nil)
(setq tab-width 2)

(provide 'init-basic-settings)
