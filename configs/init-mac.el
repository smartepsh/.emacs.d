(use-package osx-trash
             :init
             (osx-trash-setup)
             :config
             (setq delete-by-moving-to-trash t))
;; brew install trash

(use-package winum
  :init
  (setq winum-auto-setup-mode-line nil)
  (winum-mode)
  :config
  ;; window manipulation with command key
  (global-set-key (kbd "s-1") 'winum-select-window-1)
  (global-set-key (kbd "s-2") 'winum-select-window-2)
  (global-set-key (kbd "s-3") 'winum-select-window-3)
  (global-set-key (kbd "s-4") 'winum-select-window-4)
  (global-set-key (kbd "s-5") 'winum-select-window-5)
  (global-set-key (kbd "s-6") 'winum-select-window-6)
  (global-set-key (kbd "s-7") 'winum-select-window-7)
  (global-set-key (kbd "s-8") 'winum-select-window-8)
  (global-set-key (kbd "s-9") 'winum-select-window-9)
  )

  (defun copy-to-clipboard()
    "Copies selection to x-clipboard."
    (interactive)
    (if (display-graphic-p)
	  (progn
	    (shell-command-on-region (region-beginning) (region-end) "pbcopy")
	    (message "Yanked region to clipboard!")
	    (deactivate-mark))
	(message "No region active; can't yank to clipboard!"))
    )

  (defun paste-from-clipboard ()
    "Pastes from x-clipboard."
    (interactive)
      (insert (shell-command-to-string "pbpaste"))
    )

 ;; Keybindings
    ;; (global-set-key (kbd-mac-command "=") 'spacemacs/scale-up-font)
    ;; (global-set-key (kbd-mac-command "-") 'spacemacs/scale-down-font)
    (global-set-key (kbd "s-=") 'cnfonts-increase-fontsize)
    (global-set-key (kbd "s--") 'cnfonts-decrease-fontsize)
    (global-set-key (kbd "s-0") 'spacemacs/reset-font-size)
    (global-set-key (kbd "s-q") 'save-buffers-kill-terminal)
    ;; (global-set-key (kbd-mac-command "v") 'clipboard-yank)
    ;; (global-set-key (kbd-mac-command "c") 'clipboard-kill-ring-save)
    (global-set-key (kbd "s-v") 'paste-from-clipboard)
    (global-set-key (kbd "s-c") 'copy-to-clipboard)
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
    (global-set-key (kbd "s-s-h") 'ns-do-hide-others)

(provide 'init-mac)
