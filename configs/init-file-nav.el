;; (use-package neotree
;;   :general
;;   (general-define-key
;;    "<f5>" 'neotree-toggle))

(use-package dired
  :ensure nil
  :ensure-system-package (gls . coreutils)
  :commands (dired-jump dired-jump-other-window)
  :init
  (setq dired-dwim-target t
	dired-listing-switches "-alh"
	insert-directory-program "gls"
	dired-use-ls-dired t)
  :config
  (add-to-list 'evil-normal-state-modes 'wdired-mode)
  :general
  (general-nmap
   :keymaps 'dired-mode-map
   "w" 'wdired-change-to-wdired-mode
   "<return>" 'dired-find-file)
  (clear-spc
    :keymaps 'dired-mode-map)
  (common-leader
    "fd" 'dired-jump
    "fD" 'dired-jump-other-window))

(use-package hydra)

(use-package dired-quick-sort
  :hook (dired-mode . dired-quick-sort-setup))

(use-package dired-k
  :hook (dired-mode . dired-k))

(provide 'init-file-nav)
