(use-package general
  :config
  (general-evil-setup)
  (general-auto-unbind-keys)
  (general-create-definer common-leader
    :prefix-name "SPC"
    :prefix "SPC"
    :states '(motion normal emacs))
  (general-create-definer local-leader
    :prefix-name "leader"
    :prefix ","
    :states '(motion normal emacs))
  (general-create-definer clear-spc
    :prefix-name "NOSPC"
    "SPC" nil))

(use-package which-key
  :init
  (which-key-mode))

(use-package evil
  :init
  (setq evil-shift-width 2)
  (setq evil-flash-delay 1)
  (evil-mode 1)
  :config
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
	evil-escape-daly 0.1))

(provide 'init-evil)
