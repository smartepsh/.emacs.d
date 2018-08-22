(use-package prescient
  :after (:any ivy company)
  :config
  (setq prescient-filter-method 'regexp)
  (prescient-persist-mode))

(provide 'init-support)
