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


(use-package company-quickhelp
  :after company
  :init
  (company-quickhelp-mode)
  (setq company-quickhelp-delay nil
	company-quickhelp-color-background "windowBackgroundColor"
	company-quickhelp-color-foreground "wheat1"))

(provide 'init-company)
