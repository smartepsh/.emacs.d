(use-package doom-themes
  :init
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t)
  (load-theme 'doom-one t))

(scroll-bar-mode -1)
(tool-bar-mode -1)

(use-package eyebrowse
  :defer t
  :init
  (add-hook 'after-init-hook #'eyebrowse-mode)
  :config
  (global-set-key (kbd "H-1") 'eyebrowse-switch-to-window-config-1)
  (global-set-key (kbd "H-2") 'eyebrowse-switch-to-window-config-2)
  (global-set-key (kbd "H-3") 'eyebrowse-switch-to-window-config-3)
  (global-set-key (kbd "H-4") 'eyebrowse-switch-to-window-config-4)
  (global-set-key (kbd "H-5") 'eyebrowse-switch-to-window-config-5)
  (global-set-key (kbd "H-6") 'eyebrowse-switch-to-window-config-6)
  (global-set-key (kbd "H-7") 'eyebrowse-switch-to-window-config-7)
  (global-set-key (kbd "H-8") 'eyebrowse-switch-to-window-config-8)
  (global-set-key (kbd "H-9") 'eyebrowse-switch-to-window-config-9)
  (global-set-key (kbd "H-`") 'eyebrowse-rename-window-config)
  (global-set-key (kbd "H-q") 'eyebrowse-close-window-config))

(use-package evil-anzu
  :after evil
  :init
  (setq anzu-cons-mode-line-p nil)
  (add-hook 'after-init-hook #'global-anzu-mode)
  :config
  (set-face-attribute 'anzu-mode-line nil
		      :foreground "yellow" :weight 'bold))

(use-package nyan-mode
  :init
  (add-hook 'after-init-hook #'nyan-mode))

(use-package spaceline
  :init
  (setq powerline-image-apple-rgb t
	spaceline-buffer-size-p nil
	spaceline-flycheck-error-p nil
	spaceline-flycheck-warning-p nil
	spaceline-flycheck-info-p nil
	spaceline-minor-modes-p nil
	spaceline-anzu-p t
	spaceline-projectile-root-p nil
	spaceline-version-control-p nil
	powerline-default-separator 'box
	spaceline-separator-dir-left '(right . right)
	spaceline-separator-dir-right '(left . left)
	spaceline-window-numbers-unicode t
	spaceline-highlight-face-func 'spaceline-highlight-face-evil-state
	spaceline-workspace-numbers-unicode t)
  (add-hook 'after-init-hook #'spaceline-emacs-theme))

(use-package linum-relative
  :commands (linum-relative-mode linum-relative-global-mode)
  :init
  (setq linum-relative-backend 'display-line-numbers-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(provide 'init-ui)
