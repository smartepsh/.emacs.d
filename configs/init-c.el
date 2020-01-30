(use-package ccls
  :hook (c-mode . (lambda () (require 'ccls) (lsp)))
  :init
  (setq lsp-prefer-flymake nil)
  (setq ccls-executable "/usr/local/bin/ccls"))

(provide 'init-c)
