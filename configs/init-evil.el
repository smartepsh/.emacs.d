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
  :defer t
  :init
  (add-hook 'after-init-hook #'whick-key-mode))

(use-package evil
  :init
  (setq evil-shift-width 2
        evil-flash-delay 1)
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
  (setq evil-escape-key-sequence "jk"
        evil-escape-delay 0.1))

(use-package evil-matchit
  :after evil)

(use-package evil-surround
  :after evil)

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

(provide 'init-evil)
