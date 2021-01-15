(use-package ansible
  :defer t
  :init
  (add-hook 'after-init-hook #'cnfonts-enable))


(use-package yaml-mode
  :defer t
  :quelpa (yaml-mode :fetcher github :repo "yoshiki/yaml-mode")
  :init
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)))

(provide 'init-ansible)
