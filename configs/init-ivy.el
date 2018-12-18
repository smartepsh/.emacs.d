(use-package ivy
  :defer t
  :ensure-system-package (ag . the-silver-searcher)
  :init
  (add-hook 'after-init-hook #'ivy-mode)
  (setq ivy-use-virtual-buffers t
        enable-recursive-minibuffers t)
  :config
  (add-to-list 'evil-normal-state-modes 'ivy-occur-grep-mode)
  :general
  (general-define-key
   :keymaps 'ivy-minibuffer-map
   [escape] 'minibuffer-keyboard-quit)
  (clear-spc
    :keymaps 'ivy-occur-grep-mode-map)
  (local-leader
    :keymaps 'ivy-occur-grep-mode-map
    "w" 'ivy-wgrep-change-to-wgrep-mode)
  (common-leader
    "/" 'counsel-ag))

(use-package swiper
  :commands (swiper)
  :general
  (general-define-key
   "C-s" 'swiper))

(use-package counsel
  :after ivy)

(use-package ivy-rich
  :after ivy
  :init
  (setq ivy-virtual-abbreviate 'full
	ivy-rich-switch-buffer-align-virtual-buffer t))
  ;; :config
  ;; (ivy-set-display-transformer 'ivy-switch-buffer 'ivy-rich-switch-buffer-transformer))

(use-package ivy-prescient
  :after ivy
  :config
  (setq ivy-prescient-retain-classic-highlighting t)
  (ivy-prescient-mode))

(use-package all-the-icons-ivy
  :after ivy
  :init
  (setq all-the-icons-ivy-file-commands
	`(counsel-find-file counsel-file-jump counsel-recentf counsel-projectile counsel-projectile-find-file counsel-projectile-find-dir counsel-git counsel-ibuffer))
  :config
  (all-the-icons-ivy-setup))


(provide 'init-ivy)
