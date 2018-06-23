(use-package doom-themes
             :init
             (setq doom-themes-enable-bold t
                   doom-themes-enable-italic t)
             (load-theme 'doom-one t))

(use-package spaceline
  :init
  (spaceline-emacs-theme))

(use-package spaceline-all-the-icons
  :after spaceline
  :config
  (spaceline-all-the-icons-theme))

(scroll-bar-mode -1)
(tool-bar-mode -1)

(provide 'init-ui)
