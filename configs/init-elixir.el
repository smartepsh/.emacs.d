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
  (add-hook 'elixir-mode-hook 'alchemist-mode)
  :config
  (defun run-elixir-tests ()
    (interactive)
    (if (string-equal "exs" (file-name-extension (buffer-file-name (current-buffer))))
    (alchemist-mix-test-this-buffer)
    (alchemist-project-run-tests-for-current-file)))

  (setq alchemist-test-status-modeline nil
	alchemist-test-display-compilation-output t
	alchemist-test-truncate-lines nil)
	;; alchemist-goto-elixir-source-dir "~/kenton/elixir"
	;; alchemist-goto-elixir-source-dir "/usr/local/Cellar/elixir/1.7.2")
	;; alchemist-goto-erlang-source-dir "~/kenton/erlang")
  :general
  (local-leader
    :keymaps 'alchemist-mode-map
    "." '(alchemist-goto-definition-at-point :which-key "jump-to")
    "," '(alchemist-goto-jump-back :which-key "jump-back")

    "t" '(:ignore t :which-key "test")
    "ta" 'alchemist-mix-test
    "tt" 'alchemist-mix-test-at-point
    "tb" 'run-elixir-tests
    "tr" 'alchemist-mix-rerun-last-test
    "ts" 'alchemist-mix-test-stale
    "tw" 'alchemist-test-toggle-test-report-display
    "tf" 'alchemist-project-toggle-file-and-tests

    "m" '(:ignore t :which-key "mix")
    "m:" 'alchemist-mix-run
    "mx" 'alchemist-mix
    "mc" 'alchemist-mix-compile
    "mr" 'alchemist-mix-rerun-last-task

    "h" '(:ignore t :which-key "hex")
    "hi" 'alchemist-hex-info-at-point
    "hr" 'alchemist-hex-releases-at-point
    "hI" 'alchemist-hex-info
    "hR" 'alchemist-hex-releases
    "hs" 'alchemist-hex-search
    "hd" 'alchemist-hex-all-dependences

    "c" '(:ignore t :which-key "compile")
    "cb" 'alchemist-compile-this-buffer
    "cc" 'alchemist-compile

    "p" '(:ignore t :which-key "project")
    "ps" 'alchemist-project-toggle-file-and-tests
    "po" 'alchemist-project-toggle-file-and-tests-other-window
    "pt" 'alchemist-project-run-tests-for-current-file
    "pf" 'alchemist-project-find-test
    "pl" 'alchemist-project-find-lib

    "f" '(:ignore t :which-key "phoenix-find")
    "fw" 'alchemist-phoenix-find-web
    "fc" 'alchemist-phoenix-find-controllers
    "fl" 'alchemist-phoenix-find-channels
    "ft" 'alchemist-phoenix-find-templates
    "fm" 'alchemist-phoenix-find-models
    "fv" 'alchemist-phoenix-find-views
    "fs" 'alchemist-phoenix-find-static
    "fr" 'alchemist-phoenix-router
    "fR" 'alchemist-phoenix-routes

    "h" '(:ignore t :which-key "help")
    "hh" 'alchemist-help
    "hi" 'alchemist-help-history
    "he" 'alchemist-help-search-at-point
    "hr" 'alchemist-refcard

    "g" '(:ignore t :which-key "goto")
    "gg" 'alchemist-goto-definition-at-point
    "gb" 'alchemist-goto-definition-at-point
    "gp" 'alchemist-jump-to-previous-def-symbol
    "gn" 'alchemist-jump-to-next-def-symbol
    "gs" 'alchemist-goto-list-symbol-definitions'

    "i" '(:ignore t :which-key "iex")
    "ii" 'alchemist-iex-run
    "ip" 'alchemist-iex-project-run
    "il" 'alchemist-iex-send-current-line
    "ic" 'alchemist-iex-send-current-line-and-go
    "ir" 'alchemist-iex-send-region
    "im" 'alchemist-iex-send-region-and-go
    "ib" 'alchemist-iex-compile-this-buffer
    "iR" 'alchemist-iex-reload-module

    "e" '(:ignore :which-key "eval")
    "el" 'alchemist-eval-current-line
    "ek" 'alchemist-eval-print-current-line
    "ej" 'alchemist-eval-quoted-current-line
    "eh" 'alchemist-eval-print-quoted-current-line
    "eo" 'alchemist-eval-eval-region
    "ei" 'alchemist-eval-print-region
    "eu" 'alchemist-eval-quotaed-region
    "ey" 'alchemist-eval-print-quoted-region
    "eq" 'alchemist-eval-buffer
    "ew" 'alchemist-eval-print-buffer
    "ee" 'alchemist-eval-quoted-buffer
    "er" 'alchemist-eval-print-quoted-buffer
    "e!" 'alchemist-eval-close-popup

    "o" '(:ignore t :which-key "macro")
    "ol" 'alchemist-macroexpand-once-current-line
    "oL" 'alchemist-macroexpand-once-print-current-line
    "ok" 'alchemist-macroexpand-current-line
    "oK" 'alchemist-macroexpand-print-current-line
    "oi" 'alchemist-macroexpand-once-region
    "oI" 'alchemist-macroexpand-once-print-region
    "or" 'alchemist-macroexpand-region
    "oR" 'alchemist-macroexpand-print-region
    "o!" 'alchemist-macroexpand-close-popup))

;; (use-package dap-elixir
;;   :commands (dap-debug-edit-template)
;;   :ensure dap-mode)

(provide 'init-elixir)
