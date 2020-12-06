(use-package format-all
  :hook (elixir-mode . format-all-mode)
  :hook (emacs-lisp-mode . format-all-mode)
  :commands format-all-buffer)

(provide 'init-prog)
