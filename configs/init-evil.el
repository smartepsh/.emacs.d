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

(provide 'init-evil)
