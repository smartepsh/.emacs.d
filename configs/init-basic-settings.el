(use-package popwin
  :defer t
  :init
  (add-hook 'after-init-hook #'popwin-mode))

(setq ring-bell-function 'ignore
      scroll-margin 0
      scroll-conservatively 1001
      scroll-preserve-screen-position t)

(fset #'yes-or-no-p #'y-or-n-p)

(setq-default ident-tabs-mode nil)
(setq tab-width 2)

(provide 'init-basic-settings)
