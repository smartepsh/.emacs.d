(use-package lsp-mode
  ;; :hook (elixir-mode . lsp)
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

;; (use-package lsp-ui
;;   :after (lsp-mode)
;;   :hook (lsp-mode . lsp-ui-mode))
;;
;; (use-package company-lsp
;;   :after (company, lsp-mode)
;;   :init
;;   (setq company-lsp-enable-snippet t)
;;   (push 'company-lsp company-backends))
;;
;; (use-package dap-mode
;;   :defer t
;;   :init
;;   (add-hook 'lsp 'dap-mode)
;;   (add-hook 'lsp 'dap-ui-mode)
;;   :config
;;   (dap-tootip-mode t)
;;   (tootip-mode t))
;;
;;
(provide 'init-lsp)
