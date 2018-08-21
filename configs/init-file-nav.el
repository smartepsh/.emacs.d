;; (use-package neotree
;;   :general
;;   (general-define-key
;;    "<f5>" 'neotree-toggle))

(use-package dired
  :ensure nil
  :general
  (clear-spc
    :keymaps 'dired-mode-map)
  (common-leader
    "fd" 'dired-jump
    "fD" 'dired-jump-other-window))

(global-set-key [f5] 'neotree-toggle)

(provide 'init-file-nav)
