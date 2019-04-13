(use-package js2-mode
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))

(use-package indium
  :defer t
  :ensure-system-package (indium . "npm install -g indium")
  :hook ('js2-mode-hook 'indium-interaction-mode)
  )

(use-package tern
  :defer t
  :ensure-system-package (tern . "npm install -g tern")
  :hook ('js2-mode-hook 'tern-mode)
  )

(provide 'init-js)
