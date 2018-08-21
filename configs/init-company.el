(use-package company
  :defer t
  :init
  (global-company-mode)
  (setq company-idle-delay nil
	company-require-match 'never
	company-tooltip-align-annotations t
	company-dabbrev-ignore-case nil
	company-dabbrev-downcase nil)

  (setq company-backends
	'(company-keywords
	  company-files
	  company-caps
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

(use-package smartparens
  :hook (prog-mode . smartparens-mode)
  :config
  (show-smartparens-mode))

(provide 'init-company)
