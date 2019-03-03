(use-package web-mode
  :defer t
  :init
  (add-to-list
   'auto-mode-alist '("\\.eex\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2
	web-mode-css-indent-offset 2
	web-mode-code-indent-offset 2
	web-mode-comment-style 2))

(provide 'init-web)
