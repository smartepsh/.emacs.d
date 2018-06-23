(use-package company
  :delight
  :defer t
  :init
  (global-company-mode)
  :config
  (setq company-backends
	'(company-keywords
	  company-files
	  company-caps
	  company-dabbrev-code
	  company-dabbrev)))

(use-package company-statistics
  :defer t
  :init
  (add-hook 'company-mode-hook 'company-statistics-mode))

(use-package smartparens
  :delight
  :defer t
  :init
  (smartparens-global-mode)
  :config
  (show-smartparens-mode))

(provide 'init-company)
