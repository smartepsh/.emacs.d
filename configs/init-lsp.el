(use-package lsp-mode
  :hook (elixir-mode . lsp)
  :commands lsp
  :init
  (add-to-list 'exec-path "~/.emacs.d/lsp/")
  )

(use-package lsp-ui
  :commands lsp-ui-mode
  )

(use-package company-lsp
  :defer t
  :init
  (push 'company-lsp company-backends))

(use-package dap-mode
  :defer t
  :init
  (add-hook 'lsp 'dap-mode)
  (add-hook 'lsp 'dap-ui-mode)
  :config
  (dap-tootip-mode t)
  (tootip-mode t))

(provide 'init-lsp)
