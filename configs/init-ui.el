(use-package doom-themes
  :init
  (setq doom-themes-enable-bold t
  doom-themes-enable-italic t)
  (load-theme 'doom-one t))

(use-package all-the-icons)

(use-package spaceline
  :defer t
  :init
  (spaceline-emacs-theme)
  :config
  
)

(scroll-bar-mode -1)
(tool-bar-mode -1)

(provide 'init-ui)
