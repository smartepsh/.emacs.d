(use-package lsp-mode
  :hook (c-mode . lsp)
  :commands lsp
  ;; :ensure-system-package (tsc . "npm install -g typescript")
  ;; :ensure-system-package (typescript-language-server . "npm install -g typescript-language-server")
  ;; :ensure-system-package (vls . "npm install -g vue-language-server")
  :init
  (add-to-list 'exec-path "~/.emacs.d/lsp/")
  (add-to-list 'company-backends 'company-lsp)
  (setq lsp-keymap-prefix "s-l")
  :config
  (setq lsp-file-watch-threshold nil))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode))

(use-package company-lsp
  :init
  (setq company-lsp-enable-snippet t)
  (push 'company-lsp company-backends))

(use-package lsp-ivy
  :commands lsp-ivy-workspace-symbol)

;; (use-package dap-mode
;;   :init
;;   (add-hook 'lsp 'dap-mode)
;;   (add-hook 'lsp 'dap-ui-mode)
;;   :config
;;   ;; (require 'dap-lldb)
;;   (dap-tooltip-mode t)
;;   (tooltip-mode t))

(provide 'init-lsp)
