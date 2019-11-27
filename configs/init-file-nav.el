(use-package neotree
  :defer t
  :commands (neotree neotree-toggle)
  :init
  :config
  (setq neo-theme(if (display-graphic-p) 'icons 'arrow))
  (common-leader
    "ft" 'neotree-toggle)
  (general-nmap
    :keymaps 'neotree-mode-map
    "a" 'neotree-stretch-toggle
    "r" 'neotree-rename-node
    "c" 'neotree-create-node
    "d" 'neotree-delete-node
    "h" 'neotree-hidden-file-toggle
    "J" 'neotree-select-up-node
    "K" 'neotree-select-down-node
    "R" 'neotree-change-root
    "g" 'neotree-refresh
    "<return>" 'neotree-quick-look))

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
   "+" 'dired-create-directory
   "gb" 'revert-buffer
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
