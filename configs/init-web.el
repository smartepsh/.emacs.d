;; (require 'vue-minor-mode)

(use-package web-mode
  :init
  ;; (add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.eex\\'" . web-mode))
  ;; (add-hook 'web-mode-hook 'enable-vue-minor-mode)
  ;; (add-hook 'css-mode-hook 'enable-vue-minor-mode)
  ;; (add-hook 'scss-mode-hook 'enable-vue-minor-mode)
  :config
  (setq web-mode-markup-indent-offset 2
	web-mode-css-indent-offset 2
	web-mode-code-indent-offset 2
	web-mode-comment-style 2))

(use-package js2-mode
  :defer t
  :init
  (add-hook 'js2-mode-hook 'enable-vue-minor-mode)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))

(use-package indium
  :defer t
  :ensure-system-package (indium . "npm install -g indium")
  :hook ('js2-mode-hook 'indium-interaction-mode))

(provide 'init-web)
