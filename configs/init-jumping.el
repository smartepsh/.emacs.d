(use-package avy
  :commands (avy-goto-char-2 avy-goto-line)
  :config
  (setq avy-all-windows nil
	avy-background t)
  :general
  (common-leader
    "jj" 'avy-goto-char-2
    "jl" 'avy-goto-line))

(provide 'init-jumping)
