;; (use-package format-all
;;   :hook (elixir-mode . format-all-mode)
;;   :hook (emacs-lisp-mode . format-all-mode)
;;   :commands format-all-buffer)

(use-package format-all
  :quelpa (format-all :fetcher github :repo "lassik/emacs-format-all-the-code")
  :hook (elixir-mode . format-all-mode)
  :hook (sql-mode . format-all-mode)
  :hook (emacs-lisp-mode . format-all-mode))

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

(provide 'init-prog)
