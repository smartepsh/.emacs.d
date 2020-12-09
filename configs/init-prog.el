(use-package format-all
  :hook (elixir-mode . format-all-mode)
  :hook (emacs-lisp-mode . format-all-mode)
  :commands format-all-buffer)

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

(provide 'init-prog)
