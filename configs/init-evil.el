(use-package general
  :config
  (general-evil-setup)
  (general-auto-unbind-keys)
  (general-create-definer common-leader
    :prefix-name "SPC"
    :global-prefix "H-g"
    :prefix "SPC"
    :states '(motion normal emacs))
  (general-create-definer local-leader
    :prefix-name "leader"
    :global-prefix "H-b"
    :prefix ","
    :states '(motion normal emacs))
  (general-create-definer clear-spc
    :prefix-name "NOSPC"
    "SPC" nil))

(use-package which-key
  :init
  (add-hook 'after-init-hook #'which-key-mode))

(use-package evil
  :init
  (setq evil-shift-width 2
        evil-flash-delay 1
	evil-want-integration nil)
  (evil-mode)
  :config
  (setq-default evil-shift-width 2)
  (mapc #'evil-declare-ignore-repeat
    '(kill-this-buffer
     ido-kill-buffer
     save-buffer
     split-window-below
     split-window-below-and-focus
     split-window-right
     split-window-right-and-focus)))

(use-package evil-escape
  :after evil
  :config
  (evil-escape-mode)
  (setq evil-escape-key-sequence "jk"
        evil-escape-delay 0.1))

(use-package evil-matchit
  :after evil
  :config
  (evil-matchit-mode t))

(use-package evil-surround
  :after evil
  :config (global-evil-surround-mode t)
  :general
  (general-define-key
   :states 'motion
   "s" 'evil-surround-region))

(use-package evil-embrace
  :after evil-surround
  :config
  (evil-embrace-enable-evil-surround-integration))

(use-package free-keys
  :commands free-keys)

(use-package evil-nerd-commenter
  :commands (evilnc-comment-or-uncomment-lines)
  :config
  (evilnc-default-hotkeys)
  :general
  (common-leader
    "gc" 'evilnc-comment-or-uncomment-lines))

(use-package evil-visualstar
  :after evil
  :config
  (setq evil-visualstar/persistent t)
  (global-evil-visualstar-mode))

;; (use-package evil-collection
;;   :after evil
;;   :config
;;   (evil-collection-init))

;; (use-package multiple-cursors
;;   :defer t
;;   :general
;;   (general-define-key
;;    "C-s-l" 'mc/edit-lines
;;    "C-s-n" 'mc/mark-next-like-this
;;    "C-s-p" 'mc/mark-previous-like-this
;;    "C-s-b" 'mc/mark-all-like-this))

(use-package evil-mc
  :after evil
  :init
  (global-evil-mc-mode t))

(provide 'init-evil)
