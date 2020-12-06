(use-package osx-trash
             :init
             (setq delete-by-moving-to-trash t)
             (osx-trash-setup))

(use-package winum
  :defer t
  :init
  (setq winum-auto-setup-mode-line nil)
  (add-hook 'after-init-hook #'winum-mode)
  (setq winum-ignored-buffers-regexp '(".*\\*NeoTree\\*.*"))
  :general
  (general-define-key
   "s-1" 'winum-select-window-1
   "s-2" 'winum-select-window-2
   "s-3" 'winum-select-window-3
   "s-4" 'winum-select-window-4
   "s-5" 'winum-select-window-5
   "s-6" 'winum-select-window-6
   "s-7" 'winum-select-window-7
   "s-8" 'winum-select-window-8
   "s-9" 'winum-select-window-9))

;; (defun copy-to-clipboard()
;;   "Copies selection to x-clipboard."
;;   (interactive)
;;   (if (display-graphic-p)
;;       (progn
;; 	(shell-command-on-region (region-beginning) (region-end) "pbcopy")
;; 	(message "Yanked region to clipboard!")
;; 	(deactivate-mark))
;;     (message "No region active; can't yank to clipboard!"))
;;   )

;; (defun paste-from-clipboard ()
;;   "Pastes from x-clipboard."
;;   (interactive)
;;   (insert (shell-command-to-string "pbpaste"))
;;   )

;; Keybindings
;; (global-set-key (kbd-mac-command "=") 'spacemacs/scale-up-font)
;; (global-set-key (kbd-mac-command "-") 'spacemacs/scale-down-font)
(global-set-key (kbd "s-=") 'cnfonts-increase-fontsize)
(global-set-key (kbd "s--") 'cnfonts-decrease-fontsize)
(global-set-key (kbd "s-0") 'spacemacs/reset-font-size)
(global-set-key (kbd "s-q") 'save-buffers-kill-terminal)
;; (global-set-key (kbd-mac-command "v") 'clipboard-yank)
;; (global-set-key (kbd-mac-command "c") 'clipboard-kill-ring-save)
;; (global-set-key (kbd "s-v") 'paste-from-clipboard)
;; (global-set-key (kbd "s-c") 'copy-to-clipboard)
(global-set-key (kbd "s-a") 'mark-whole-buffer)
;; (global-set-key (kbd-mac-command "x") 'clipboard-kill-region)
(global-set-key (kbd "s-x") 'kill-region)
(global-set-key (kbd "s-w") 'delete-window)
(global-set-key (kbd "s-W") 'delete-frame)
(global-set-key (kbd "s-n") 'make-frame)
(global-set-key (kbd "s-`") 'other-frame)
(global-set-key (kbd "s-z") 'undo-tree-undo)
(global-set-key (kbd "s-Z") 'undo-tree-redo)
(global-set-key (kbd "s-s") 'evil-write)

(global-set-key (kbd "<C-s-268632070>") 'toggle-frame-fullscreen)
(global-set-key (kbd "s-C-f") 'toggle-frame-fullscreen)
(global-set-key (kbd "s-M-f") 'toggle-frame-maximized)
(global-set-key (kbd "s-s-h") 'ns-do-hide-others)

(provide 'init-mac)
