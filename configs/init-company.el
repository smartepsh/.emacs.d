(use-package company
  :defer t
  :init
  (add-hook 'after-init-hook #'global-company-mode)
  (setq company-idle-delay 0.1
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

  (setq evil-complete-next-func '+evil-complete
	evil-complete-previous-func '+evil-complete)

  :general
  (general-define-key
   :keymaps 'company-active-map
   "C-w" nil
   "C-n" 'company-select-next
   "C-p" 'company-select-previous))

(use-package company-statistics
  :hook (company-mode . company-statistics-mode))

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

(provide 'init-company)
