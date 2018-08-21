;; (use-package neotree
;;   :general
;;   (general-define-key
;;    "<f5>" 'neotree-toggle))

(use-package dired
  :ensure nil
  :commands (dired-jump dired-jump-other-window)
  :init
  (setq dired-dwim-target t
	dired-listing-switches "-alh")
  :config
  (add-to-list 'evil-normal-state-modes 'wdired-mode)
  :general
  (general-nmap
   :keymaps 'dired-mode-map
   "w" 'wdired-change-to-wdired-mode)
  (clear-spc
    :keymaps 'dired-mode-map)
  (common-leader
    "fd" 'dired-jump
    "fD" 'dired-jump-other-window))

(use-package dired-k
  :hook dired-mode
  :config
  (dired-k))

(provide 'init-file-nav)
