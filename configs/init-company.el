;; (require 'company-simple-complete)

(use-package company
  :defer t
  :init
  (add-hook 'after-init-hook #'global-company-mode)
  (setq company-idle-delay 0.3
	company-require-match 'never
	company-tooltip-align-annotations t
	company-dabbrev-ignore-case nil
	company-dabbrev-downcase nil)

  (setq company-backends
	'(company-keywords
	  company-files
	  company-capf
	  company-yasnippet
	  company-dabbrev-code
	  company-dabbrev))

  :config
  (defun +evil-complete (arg)
    (interactive)
    (unless (company-complete)
      (hippie-expand arg)))

  (setq
   company-require-match nil
   evil-complete-next-func '+evil-complete
   evil-complete-previous-func '+evil-complete)

  :general
  (general-define-key
   :keymaps 'company-active-map
   "<tab>" 'company-complete-selection
   ;; "TAB" 'company-simple-complete-next
   ;; "<S-tab>" 'company-simple-complete-previous
   "<RET>" nil
   "<return>" nil
   "C-w" nil
   "C-n" 'company-select-next
   "C-p" 'company-select-previous
   "M-h" 'company-quickhelp-manual-begin))

;; (use-package company-statistics
;;   :hook (company-mode . company-statistics-mode))

(use-package company-prescient
  :after company
  :config
  (company-prescient-mode))

(use-package smartparens
  :hook (prog-mode . smartparens-mode)
  :config
  (show-smartparens-mode))

(use-package yasnippet
  :hook (prog-mode . yas-minor-mode))

(use-package yasnippet-snippets
  :after yasnippet
  :config
  (yas-reload-all))

(use-package lsp-mode
  :ensure-system-package (tsc . "npm install -g typescript")
  :ensure-system-package (typescript-language-server . "npm install -g typescript-language-server")
  :ensure-system-package (vls . "npm install -g vue-language-server")
  :hook (js2-mode . lsp-mode)
  :config
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection "/usr/local/bin/vls")
		    :major-modes '(web-mode)
		    :ignore-messages '("readFile .*? requested by Vue but content not available")
		    :initialization-options (lambda ()
					      '(:vetur
						(:completion
						 (:autoImport t :useScaffoldSnippets t :tagCasing "kebab")
						 :grammar
						 (:customBlocks
						  (:docs "md" :i18n "json"))
						 :validation
						 (:template t :style t :script t)
						 :format
						 (:options
						  (:tabSize 2 :useTabs :json-false)
						  :defaultFormatter
						  (:html "prettyhtml" :css "prettier" :postcss "prettier" :scss "prettier" :less "prettier" :stylus "stylus-supremacy" :js "prettier" :ts "prettier")
						  :defaultFormatterOptions
						  (:js-beautify-html
						   (:wrap_attributes "force-expand-multiline")
						   :prettyhtml
						   (:printWidth 100 :singleQuote :json-false :wrapAttributes :json-false :sortAttributes :json-false))
						  :styleInitialIndent :json-false :scriptInitialIndent :json-false)
						 :trace
						 (:server "verbose")
						 :dev
						 (:vlsPath ""))
						)))))
		    ;; :initialized-fn 'my-lsp-set-cfg)))

(use-package company-lsp
  :after (company, lsp-mode)
  :init
  (setq company-lsp-enable-snippet t)
  :config
  (add-to-list 'company-backends 'company-lsp))

(use-package lsp-ui
  :after lsp-mode
  :hook lsp-mode)

(use-package company-quickhelp
  :after company
  :init
  (company-quickhelp-mode)
  (setq company-quickhelp-delay nil
	company-quickhelp-color-background "windowBackgroundColor"
	company-quickhelp-color-foreground "wheat1"))

(provide 'init-company)
