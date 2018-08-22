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
  :init
  (add-hook 'after-init-hook #'vimish-fold-global-mode)
  :custom-face
  (vimish-fold-fringe ((t (:foreground "DeepSkyBlue2"))))
  :general
  (common-leader
    "vc" `vimish-fold
    "vu" `vimish-fold-unfold
    "vl" `vimish-fold-avy
    "vz" `vimish-fold-toggle
    "vd" `vimish-fold-delete
    "vad" `vimish-fold-delete-all
    "vau" `vimish-fold-unfold-all
    "var" `vimish-fold-refold-all
    "vat" `vimish-fold-toggle-all))


(provide 'init-jumping)
