(use-package web-mode
  :init
  ;; (add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.eex\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2
	web-mode-css-indent-offset 2
	web-mode-code-indent-offset 2
	web-mode-comment-style 2))

(use-package js2-mode
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))

(use-package indium
  :defer t
  :ensure-system-package (indium . "npm install -g indium")
  :hook ('js2-mode-hook 'indium-interaction-mode)
  )

(use-package lsp-mode
  :ensure-system-package (tsc . "npm install -g typescript")
  :ensure-system-package (typescript-language-server . "npm install -g typescript-language-server")
  :ensure-system-package (vls . "npm install -g vue-language-server")
  :hook (js2-mode . lsp-mode)
  :hook (vue-mode . lsp-mode))

(use-package company-lsp
  :after (company, lsp-mode)
  :init
  (setq company-lsp-enable-snippet t)
  (add-to-list 'company-backends 'company-lsp))

(provide 'init-web)

  ;; :config
  ;; (lsp-register-client
  ;;  (make-lsp-client :new-connection (lsp-stdio-connection "/usr/local/bin/vls")
  ;; 		    :major-modes '(web-mode)
  ;; 		    :ignore-messages '("readFile .*? requested by Vue but content not available")
  ;; 		    :initialization-options (lambda ()
  ;; 					      '(:vetur
  ;; 						(:completion
  ;; 						 (:autoImport t :useScaffoldSnippets t :tagCasing "kebab")
  ;; 						 :grammar
  ;; 						 (:customBlocks
  ;; 						  (:docs "md" :i18n "json"))
  ;; 						 :validation
  ;; 						 (:template t :style t :script t)
  ;; 						 :format
  ;; 						 (:options
  ;; 						  (:tabSize 2 :useTabs :json-false)
  ;; 						  :defaultFormatter
  ;; 						  (:html "prettyhtml" :css "prettier" :postcss "prettier" :scss "prettier" :less "prettier" :stylus "stylus-supremacy" :js "prettier" :ts "prettier")
  ;; 						  :defaultFormatterOptions
  ;; 						  (:js-beautify-html
  ;; 						   (:wrap_attributes "force-expand-multiline")
  ;; 						   :prettyhtml
  ;; 						   (:printWidth 100 :singleQuote :json-false :wrapAttributes :json-false :sortAttributes :json-false))
  ;; 						  :styleInitialIndent :json-false :scriptInitialIndent :json-false)
  ;; 						 :trace
  ;; 						 (:server "verbose")
  ;; 						 :dev
  ;; 						 (:vlsPath ""))
  ;; 						)))))
  ;; 		    ;; :initialized-fn 'my-lsp-set-cfg)))
