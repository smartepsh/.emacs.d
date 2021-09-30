(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev))
  (meow-leader-define-key
   ;; SPC j/k will run the original command in MOTION sitch-tate.
   '("j" . meow-motion-origin-command)
   '("k" . meow-motion-origin-command)
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("C" . meow-change-save)
   '("d" . meow-C-d)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("F" . meow-find-expand)
   '("g" . meow-cancel)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("N" . meow-pop-search)
   '("o" . meow-block)
   '("O" . meow-block-expand)
   '("p" . meow-yank)
   '("P" . meow-yank-pop)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("T" . meow-till-expand)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("V" . meow-kmacro-matches)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-kmacro-lines)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("Z" . meow-pop-all-selection)
   '("&" . meow-query-replace)
   '("%" . meow-query-replace-regexp)
   '("'" . repeat)
   '("\\" . quoted-insert)
   '("<escape>" . meow-last-buffer)))

(use-package meow
             :demand t
             :init
             (meow-global-mode t)
             :config
             (meow-setup))
(use-package doom-modeline
  :init
  (doom-modeline-mode t)
  :config
  (setq doom-modeline-vcs-max-length 0))
(use-package doom-themes
  :init
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t)
  (load-theme 'doom-one t))

(scroll-bar-mode -1)
(tool-bar-mode -1)
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package hl-todo
  :hook (prog-mode . hl-todo-mode))

(use-package centaur-tabs
  :config
  (general-define-key
   "s-d" 'switch-window-then-split-right
   "s-w" 'switch-window-then-delete
   "s-1" 'centaur-tabs-select-visible-tab
   "s-2" 'centaur-tabs-select-visible-tab
   "s-3" 'centaur-tabs-select-visible-tab
   "s-4" 'centaur-tabs-select-visible-tab
   "s-5" 'centaur-tabs-select-visible-tab
   "s-6" 'centaur-tabs-select-visible-tab
   "s-7" 'centaur-tabs-select-visible-tab
   "s-t" 'centaur-tabs--create-new-tab)
  ;;;(setq switch-window-input-style 'minibuffer)
  ;;;(setq switch-window-minibuffer-shortcut ?m)
  (centaur-tabs-mode t)
  (setq centaur-tabs-height 20
        centaur-tabs-set-bar 'left
        centaur-tabs-close-button "x"
        centaur-tabs-set-close-button nil
        ;;centaur-tabs--buffer-show-groups t
        centaur-tabs-set-modified-marker t
        ;;centaur-tabs-label-fixed-length 10
        centaur-tabs-set-icons t))
(use-package eyebrowse
  :defer t
  :init
  (add-hook 'after-init-hook #'eyebrowse-mode)
  (setq eyebrowse-keymap-prefix "")
  :config
  (general-define-key
   "H-1" 'eyebrowse-switch-to-window-config-1
   "H-2" 'eyebrowse-switch-to-window-config-2
   "H-3" 'eyebrowse-switch-to-window-config-3
   "H-4" 'eyebrowse-switch-to-window-config-4
   "H-5" 'eyebrowse-switch-to-window-config-5
   "H-6" 'eyebrowse-switch-to-window-config-6
   "H-7" 'eyebrowse-switch-to-window-config-7
   "H-8" 'eyebrowse-switch-to-window-config-8
   "H-9" 'eyebrowse-switch-to-window-config-9
   "H-`" 'eyebrowse-rename-window-config
   "H-q" 'eyebrowse-close-window-config))

(provide 'init-meow)
