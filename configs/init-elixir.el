(use-package elixir-mode
  :defer t
  :config
  (add-hook 'elixir-mode-hook
	    (lambda() (add-hook 'before-save-hook 'elixir-format nil t)))

  (defun +reset-mixfmt-args ()
    (let* ((formatter-directory (locate-dominating-file default-directory ".formatter.exs"))
	   (formatter-file (concat formatter-directory ".formatter.exs")))
      (if formatter-directory
	  (setq elixir-format-arguments (list "--dot-formatter" formatter-file))
	(setq elixir-format-arguments nil))))

  (add-hook 'elixir-format-hook #'+reset-mixfmt-args))

(use-package alchemist
  :defer t
  :init
  (add-hook 'elixir-mode-hook 'alchemist-mode))

(provide 'init-elixir)
