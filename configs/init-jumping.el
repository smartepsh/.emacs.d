(use-package avy
  :commands (avy-goto-char-2 avy-goto-line)
  :config
  (setq avy-all-windows nil
	avy-background t)
  :general
  (common-leader
    "jj" 'avy-goto-char-2
    "jl" 'avy-goto-line))

(use-package vimish-fold
  :defer t
  :config
  (vimish-fold-global-mode t)
  :general
  (common-leader
    :keymaps 'vimish-fold-mode-map
    "fc" `vimish-fold
    "fu" `vimish-fold-unfold
    "fj" `vimish-fold-avy
    "fz" `vimish-fold-toggle
    "fd" `vimish-fold-delete
    "fad" `vimish-fold-delete-all
    "fau" `vimish-fold-unfold-all
    "far" `vimish-fold-refold-all
    "fat" `vimish-fold-toggle-all))


(provide 'init-jumping)
