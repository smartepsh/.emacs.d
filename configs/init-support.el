(use-package prescient
  :after (:any ivy company)
  :config
  (setq prescient-filter-method 'regexp)
  (prescient-persist-mode))

(use-package wgrep
  :after (:any ivy)
  :config
  (setq wgrep-auto-save-buffer t))

(provide 'init-support)
