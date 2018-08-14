(use-package doom-themes
  :init
  (setq doom-themes-enable-bold t
  doom-themes-enable-italic t)
  (load-theme 'doom-one t))

(scroll-bar-mode -1)
(tool-bar-mode -1)

(use-package eyebrowse
  :ensure t
  :init
  (eyebrowse-mode t))

(use-package evil-anzu
  :after evil
  :init
  (setq anzu-cons-mode-line-p nil)
  (global-anzu-mode 1)
  :config
  (set-face-attribute 'anzu-mode-line nil
		      :foreground "yellow" :weight 'bold)
  )

(use-package nyan-mode
  :ensure t
  :init
  (nyan-mode))

(use-package spaceline
  :ensure t
  :config
  (setq powerline-image-apple-rgb t
	spaceline-buffer-size-p nil
	spaceline-flycheck-error-p nil
	spaceline-flycheck-warning-p nil
	spaceline-flycheck-info-p nil
	spaceline-minor-modes-p nil
	;; spaceline-anzu-p t
	;; spaceline-evil-state-p t
	;; spaceline-projectile-root-p t
	powerline-default-separator 'box
	spaceline-separator-dir-left '(right . right)
	spaceline-separator-dir-right '(left . left)
	spaceline-window-numbers-unicode t
	spaceline-highlight-face-func 'spaceline-highlight-face-evil-state
	spaceline-workspace-numbers-unicode t)
  (spaceline-emacs-theme))

(use-package linum-relative
  :defer t
  :config
  (setq linum-relative-backend 'display-line-numbers-mode))

(use-package diminish
  :ensure t
  :demand t
  :diminish abbrev-mode)

(provide 'init-ui)
