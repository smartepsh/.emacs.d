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
  (setq eyebrowse-keymap-prefix "")
  :general
  (general-define-key
   "H-1" 'eyebrowse-switch-to-window-config-1
   "H-2" 'eyebrowse-switch-to-window-config-2
   "H-3" 'eyebrowse-switch-to-window-config-3
   "H-4" 'eyebrowse-switch-to-window-config-4
   "H-5" 'eyebrowse-switch-to-window-config-5
   "H-6" 'eyebrowse-switch-to-window-config-6
   "H-7" 'eyebrowse-switch-to-window-config-7
   "H-8" 'eyebrowse-switch-to-window-config-8
   "H-9" 'eyebrowse-switch-to-window-config-9
   "H-`" 'eyebrowse-rename-window-config
   "H-q" 'eyebrowse-close-window-config))

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
	spaceline-org-pomodoro-p t
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

(use-package hl-todo
  :hook (prog-mode . hl-todo-mode))

(provide 'init-ui)
