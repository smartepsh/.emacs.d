(global-set-key (kbd "<C-s-268632070>") 'toggle-frame-fullscreen)
(global-set-key (kbd "s-C-f") 'toggle-frame-fullscreen)
(global-set-key (kbd "s-M-f") 'toggle-frame-maximized)

(defun goto-configuration-org ()
  (interactive)
  (find-file "~/.emacs.d/init_el.org"))

(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'after-init-hook '(lambda () (setq gc-cons-threshold 5121024)))

(setq read-process-output-max (* 3 (* 1024 1024))) ;; 3mb

(setq emacs-start-time (current-time))
(add-hook 'window-setup-hook '(lambda ()
                                (message
                                 (format "Emacs startup in %.3f seconds"
                                         (float-time
                                          (time-subtract
                                           (current-time)
                                           emacs-start-time))))))

(setq comp-async-jobs-number 5
      comp-deferred-compilation t
      native-comp-async-report-warnings-errors nil)

(setq private/cache-directory "~/.emacs.d/.cache/"
	 private/system-is-mac (eq system-type 'darwin)
	 private/config-directory "~/.emacs.d/"
)
   (add-to-list 'load-path (concat private/config-directory "helpers/"))

(setq custom-file "~/.emacs.d/custom.el")
(if (file-exists-p custom-file)
    (load custom-file)
  (message "no custom setting file!"))

(setq scroll-conservatively 101
      scroll-preserve-screen-position t)

(setq ring-bell-function 'ignore)

(fset 'yes-or-no-p 'y-or-n-p)

(set-default-coding-systems 'utf-8-unix)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq tab-width 2
      indent-tabs-mode nil
      auto-save-default nil
      make-backup-files nil
      create-lockfiles nil
      x-select-enable-clipboard nil)

(defun goproxy()
  (interactive)
  (setq url-proxy-services '(("no_proxy" . "^\\(localhost\\|10\\..*\\|192\\.168\\..*\\)")
                             ("http" . "192.168.50.111:8118")
                             ("https" . "192.168.50.111:8118"))))

(defun disproxy()
  (interactive)
  (setq url-proxy-services nil))

(setq ns-command-modifier 'super
      ns-option-modifer 'meta
      ns-right-option-modifier 'hyper
      ns-right-command-modifier 'hyper)

(setq confirm-kill-processes nil)

(setq package-native-compile t
      use-package-expand-minimally t
      use-package-always-ensure t
      package-enable-at-startup nil
      package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("nongnu"   . "https://elpa.nongnu.org/nongnu/")
			 ("gnu"   . "https://elpa.gnu.org/packages/")))
;; This is only needed once, near the top of the file
(eval-when-compile
  (require 'use-package))

(use-package use-package-ensure-system-package
  :ensure t)

;; disable update during quelpa initialized
(setq quelpa-update-melpa-p nil
      quelpa-checkout-melpa-p t)

;; install quelpa
(unless (package-installed-p 'quelpa)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
    (eval-buffer)
    (quelpa-self-upgrade)))

;; install quelpa-use-package
(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://github.com/quelpa/quelpa-use-package.git"))

(require 'quelpa-use-package)
(quelpa-use-package-activate-advice)

;;(use-package benchmark-init
;;  :config
;;  (add-hook 'after-init-hook 'benchmark-init/deactivate))

(use-package package-utils
  :defer t)

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev))
  (meow-leader-define-key
   ;; SPC j/k will run the original command in MOTION state.
   '("j" . "H-j")
   '("k" . "H-k")
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
   ;; '("/" . meow-keypad-describe-key)
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
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
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
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("X" . counsel-M-x)
   '("x" . meow-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("<escape>" . meow-cancel-selection)
   '("g" . mode-line-other-buffer)
   ;; customize
   '("P" . meow-yank-pop)
   '("}" . scroll-up)
   '("{" . scroll-down)
   '(":" . meow-goto-line)
   '("C-r" . undo-redo)
   '("'" . meow-start-kmacro-or-insert-counter)
   '("%" . meow-query-replace-regexp)
   '("\"" . meow-end-or-call-kmacro)))
;; '("C" . meow--save)
;; '("F" . meow-find-expand)
;; '("N" . meow-pop-search)
;; '("T" . meow-till-expand)
;; '("V" . meow-kmacro-psave)
;; '("X" . meow-kmacro-lines)
;; '("Z" . meow-pop-all-selection)
;; '("&" . meow-query-replace)
;; '("'" . repeat)
;; '("\\" . quotesaved-insert)
;; '("g" . meow-last-savesave)
;; '("S" . meow-repaaaaaaaaaaaaaaaaceaaaa-save)))

(use-package meow
  :demand t
  :init
  (setq meow-use-cursor-position-hack t
	meow-use-enhanced-selection-effect t)
  (meow-global-mode t)
  :config
  (meow-setup)
  (add-to-list 'meow-mode-state-list '(sly-mrepl-mode . normal))
  (setq meow-expand-exclude-mode-list '()
	meow-selection-command-fallback
	'((meow-change . meow-change-char)
	  (meow-replace . meow-replace-char)
	  (meow-save . meow-save-char)
	  (meow-kill . meow-C-k)
	  (meow-cancel-selection . meow-keyboard-quit)
	  (meow-pop-selection . meow-pop-grab)
	  (meow-beacon-change . meow-beacon-change-char))))

(use-package general
  :config
  (general-auto-unbind-keys))

(use-package which-key
  :defer t
  :init
  (add-hook 'after-init-hook 'which-key-mode))

(use-package command-log-mode
  :defer t
  :commands (command-log-mode))

(defun my-doom-modeline--font-height ()
  "Calculate the actual char height of the mode-line."
  (+ (frame-char-height) 2))

  (use-package doom-modeline
    :init
    (add-hook 'after-init-hook (lambda ()
				 (doom-modeline-mode)
				 (column-number-mode)
				 (doom-modeline-def-modeline 'my-line
				   '(bar workspace-name modals buffer-info buffer-position)
				   '(input-method checker major-mode parrot lsp))
				 (defun setup-custom-doom-modeline ()
				   (interactive)
				   (doom-modeline-set-modeline 'my-line 'default))
				 (setup-custom-doom-modeline)))
    :config

(advice-add 'doom-modeline--font-height :override 'my-doom-modeline--font-height)
(set-face-attribute 'mode-line nil :height 100)
     (set-face-attribute 'mode-line-inactive nil :height 100)
    (setq doom-modeline-buffer-modification-icon nil
	  doom-modeline-buffer-state-icon nil
	  doom-modeline-buffer-file-name-style 'file-name))

(use-package doom-themes
  :init
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t)
  (defun load-doom-theme (frame)
    (select-frame frame)
    (load-theme 'doom-one t))
  (if (daemonp)
      (add-hook 'after-make-frame-functions 'load-doom-theme)
    (load-theme 'doom-one t)))

(scroll-bar-mode -1)
(tool-bar-mode -1)

(use-package nyan-mode
  :init
  (add-hook 'after-init-hook 'nyan-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package hl-todo
  :hook (prog-mode . hl-todo-mode))

(use-package posframe
  :defer t)

(setq inhibit-startup-screen t)

(use-package eyebrowse
  :defer t
  :init
  (add-hook 'after-init-hook 'eyebrowse-mode)
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
   "H-q" 'eyebrowse-close-window-config
   "s-t" 'eyebrowse-create-window-config))

(use-package switch-window
  :init
  (setq switch-window-auto-resize-window t
	switch-window-minibuffer-shortcut ?z)
  (general-define-key
   "s-d" 'switch-window-then-split-right
   "s-[" 'windmove-left
   "s-]" 'windmove-right
   "s-w" 'delete-window
   "H-t" 'switch-window))

(use-package autorevert
  :defer t
  :ensure nil
  :hook (after-init . global-auto-revert-mode))

(setq private/rime-directory (concat private/config-directory "rime/")
      rime-emacs-module-header-root (concat private/config-directory "helpers/"))

(use-package cnfonts
  :ensure t
  :after all-the-icons
  :init
  (add-hook 'cnfonts-set-font-finish-hook '(lambda (fontsizes-list)
					     (set-fontset-font t 'unicode (font-spec :family "all-the-icons") nil 'append)))
  (add-hook 'after-init-hook 'cnfonts-enable)
  (setq cnfonts-use-face-font-rescale t
	cnfonts-default-fontsize 24)
  :config
  (general-define-key
   "s-=" 'cnfonts-increase-fontsize
   "s--" 'cnfonts-decrease-fontsize))

(use-package rime
  :defer t
  :custom
  (default-input-method "rime")
  :init
  (setq rime-librime-root (concat private/rime-directory "dist/")
	rime-show-candidate 'posframe
	rime-posframe-style 'vertical
	rime-show-preedit 'inline
	rime-disable-predicates '(rime-predicate-hydra-p
				  rime-predicate-prog-in-code-p
				  rime-predicate-punctuation-after-ascii-p
				  meow-normal-mode-p))
  (global-set-key (kbd "s-SPC") 'toggle-input-method)
  (general-define-key
   :keymaps 'rime-active-mode-map
   "M-j" 'rime-inline-ascii))

(setq base-directory  (file-truename "~/KentonBase/")
      private/book-directory (concat base-directory "publications/")
      org-directory (concat base-directory "orgs/"))

(use-package org-capture
  :after org
  :ensure org-plus-contrib)

(use-package org-mac-link
  :defer t
  :ensure org-plus-contrib
  :commands (org-mac-skim-insert-page
	     org-mac-safari-insert-frontmost-url
	     org-mac-finder-insert-selected))

(use-package nov
  :defer t
  :mode ("\\.epub\\'" . nov-mode)
  :init
  (setq nov-save-place-file (concat org-directory "nov-places")))

(require 'skim)

(defun nov-buffer-in-current ()
  (cl-find-if
   (lambda (window)
     (with-current-buffer (window-buffer window) (eq major-mode 'nov-mode)))
   (window-list)))

(defun reader/scroll-up (arg)
  (interactive "P")
  (let ((nov-window (nov-buffer-in-current))
	(current-window (get-buffer-window)))
    (if nov-window
	(progn
	  (select-window nov-window)
	  (nov-scroll-up arg)
	  (select-window current-window))
      (skim-next-page))))

(defun reader/scroll-down (arg)
  (interactive "P")
  (let ((nov-window (nov-buffer-in-current))
	(current-window (get-buffer-window)))
    (if nov-window
	(progn
	  (select-window nov-window)
	  (nov-scroll-down arg)
	  (select-window current-window))
      (skim-prev-page))))

(defun reader/goto-pdf-first-page-or-nov-toc ()
  (interactive)
  (let ((nov-window (nov-buffer-in-current))
	(current-window (get-buffer-window)))
    (if nov-window
	(progn
	  (select-window nov-window)
	  (nov-goto-toc)
	  (select-window current-window))
      (skim-goto 1))))

;;; Only display inline images under current subtree.
(defun org-display-subtree-inline-images (&optional state)
  "Toggle the display of inline images under current subtree.
INCLUDE-LINKED is passed to `org-display-inline-images'."
  (interactive)
  (save-excursion
    (save-restriction
      (org-narrow-to-subtree)
      (let* ((beg (point-min))
	     (end (point-max))
	     (image-overlays (cl-intersection
			      org-inline-image-overlays
			      (overlays-in beg end)))
	     (display-inline-images-local
	      (lambda ()
		(org-display-inline-images t t beg end)
		(setq image-overlays (cl-intersection
				      org-inline-image-overlays
				      (overlays-in beg end)))
		(if (and (org-called-interactively-p) image-overlays)
		    (message "%d images displayed inline"
			     (length image-overlays)))))
	     (hide-inline-images-local
	      (lambda ()
		(org-remove-inline-images)
		(message "Inline image display turned off"))))
	(if state
	    (pcase state
	      ('subtree
	       (funcall display-inline-images-local))
	      ('folded
	       (funcall hide-inline-images-local)))
	  (if image-overlays
	      (funcall display-inline-images-local)
	    (funcall hide-inline-images-local)))))))

(defun org-hide-properties ()
  "Hide all org-mode headline property drawers in buffer. Could be slow if it has a lot of overlays."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward
	    "^ *:properties:\n\\( *:.+?:.*\n\\)+ *:end:\n" nil t)
      (let ((ov_this (make-overlay (match-beginning 0) (match-end 0))))
	(overlay-put ov_this 'display "")
	(overlay-put ov_this 'hidden-prop-drawer t))))
  (put 'org-toggle-properties-hide-state 'state 'hidden))

(defun org-show-properties ()
  "Show all org-mode property drawers hidden by org-hide-properties."
  (interactive)
  (remove-overlays (point-min) (point-max) 'hidden-prop-drawer t)
  (put 'org-toggle-properties-hide-state 'state 'shown))

(defun org-toggle-properties ()
  "Toggle visibility of property drawers."
  (interactive)
  (if (eq (get 'org-toggle-properties-hide-state 'state) 'hidden)
      (org-show-properties)
    (org-hide-properties)))

(defun notify-osx (title message)
(call-process "terminal-notifier"
              nil 0 nil
              "-group" "Emacs"
              "-title" title
              "-sender" "org.gnu.Emacs"
              "-mesage" message
              "-activate" "org.gnu.Emacs"))

(use-package ob-elixir :after org)

(use-package org
  :ensure-system-package terminal-notifier
  :defer t
  :init
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (elixir . t)
     (org . t)
     (haskell . t)
     (lisp . t)))
  ;;(R . t)))
  :config
;;; auto display inline images on Org TAB cycle expand headlines.
  ;; (add-hook 'org-mode-hook 'scimax-src-keymap-mode)
  (add-hook 'org-cycle-hook #'org-display-subtree-inline-images)
  (add-to-list 'org-export-backends 'md)
  (setq org-todo-keywords '((sequence "TODO(t/!)" "WAIT(w/!)" "|" "DONE(d/!)" "DELEGATED(g@)" "CANCELED(c@)"))
	;; org-default-notes-file org-agenda-file
	org-archive-location (concat org-directory "Archived/" "%s_archive::")
	org-id-locations-file (concat org-directory ".org-id-locations")
	org-log-done nil
	;; (nconc org-modules '(org-id))
	;; org-refile-targets '((org-agenda-files :maxlevel . 2))
	org-refile-use-outline-path 'file
	org-outline-path-complete-in-steps nil
	org-refile-allow-creating-parent-nodes 'confirm
	org-refile-use-cache t
	org-startup-truncated nil
	org-confirm-babel-evaluate nil
	org-M-RET-may-split-line '((headline . nil) (item . nil) (default . t))
	org-html-validation-link nil)
  ;; refresh cache when emacs idle 5 mins
  (run-with-idle-timer 300 t (lambda ()
			       (org-refile-cache-clear)
			       ;; (org-refile-get-targets)
			       (org-roam-db-sync))))

(setq publication-bib (concat base-directory "publication_catelog.bib")
      collections-bib (concat base-directory "collections.bib"))

(use-package ivy-bibtex
  :defer t
  :init
  (setq bibtex-completion-bibliography `(,publication-bib)
	bibtex-completion-pdf-field "file"
	bibtex-completion-notes-path org-directory
	bibtex-completion-library-path (concat base-directory "collections/")
	bibtex-completion-display-formats '((article . "${=has-pdf=:1}${=has-note=:1} ${=type=:4} ${title:*} ${journal:40}")
					    (inbook . "${=has-pdf=:1}${=has-note=:1} ${=type=:4} ${title:*} Chapter ${chapter:32}")
					    (incollection . "${=has-pdf=:1}${=has-note=:1} ${=type=:4} ${title:*} ${booktitle:40}")
					    (inproceedings . "${=has-pdf=:1}${=has-note=:1} ${=type=:4} ${title:*} ${booktitle:40}")
					    (t . "${=has-pdf=:1}${=has-note=:1} ${=type=:4} ${title:*}"))
	bibtex-completion-pdf-extension '(".pdf" ".djvu")))
(use-package org-ref
  :after org
  :init
  (setq reftex-default-bibliography `(,publication-bib ,collections-bib)
	;;org-ref-bibliography-notes (concat org-directory "ref-notes.org")
	org-ref-default-bibliography `(,publication-bib ,collections-bib)
	;;org-ref-pdf-directory private/book-directory
	calibredb-ref-default-bibliography publication-bib
	org-ref-get-pdf-filename-function 'org-ref-get-mendeley-filename)
  (require 'bibtex)

  (setq bibtex-autokey-year-length 4
	bibtex-autokey-name-year-separator "-"
	bibtex-autokey-year-title-separator "-"
	bibtex-autokey-titleword-separator "-"
	bibtex-autokey-titlewords 2
	bibtex-autokey-titlewords-stretch 1
	bibtex-autokey-titleword-length 5
	org-ref-bibtex-hydra-key-binding (kbd "H-b"))

  (require 'org-ref-ivy)

  (setq org-ref-insert-link-function 'org-ref-insert-link-hydra/body
	org-ref-insert-cite-function 'org-ref-cite-insert-ivy
	org-ref-insert-label-function 'org-ref-insert-label-link
	org-ref-insert-ref-function 'org-ref-insert-ref-link
	org-ref-cite-onclick-function (lambda (_) (org-ref-citation-hydra/body))))
;; org-ref-completion-library 'org-ref-ivy-cite-completion))

(defun org-refresh-agenda-files ()
  (interactive)
  (setq org-agenda-files (directory-files (concat org-directory "journal/") t ".org")))
(use-package org-agenda
  :ensure org-plus-contrib
  :commands (org-agenda-list
	     org-agenda
	     org-agenda-to-appt)
  :init
  (org-refresh-agenda-files))

(setq private/bookmark-file (concat org-directory "bookmarks.org"))
(defun open-bookmarks ()
  (interactive)
  (if (buffer-live-p "bookmarks.org")
      (pop-to-buffer "bookmarks.org")
    (find-file private/bookmark-file)))

(use-package org-roam
  :init
  (add-hook 'after-init-hook 'org-roam-setup)
  (setq org-roam-v2-ack t
	org-roam-directory org-directory
	org-roam-db-gc-threshold most-positive-fixnum
	org-roam-db-location (concat org-directory "org-roam.db")
	org-roam-dailies-directory "journal/")

  (require 'org-roam-protocol)
  :config
  (setq org-roam-node-display-template "${hierarchy:*}
${tags:20}")
  (setq org-roam-completion-everywhere t)
  (setq org-roam-completion-system 'ivy)
  (setq org-roam-capture-ref-templates
	'(("b" "Bookmark" plain "%?\n*** ${title}\n:PROPERTIES:\n:ID: %(org-id-new)\n:ROAM_REFS: ${ref}\n:ROAM_EXCLUDE: t\n:END:" :if-new (file+olp "%(symbol-value 'bookmark-file)" ("Uncategorized")) :immediate-finish t :unnarrowed t :empty-lines-after 1))) ;;
  (setq org-roam-dailies-capture-templates
	'(("d" "dailies" entry "* %<%R> %?" :target (file+head "%<%Y%m%d-%W>.org" "#+title: %<%Y-%m-%d>\n"))))
  ;; must after use-package org-roam
  (cl-defmethod org-roam-node-filetitle ((node org-roam-node))
    "Return the file TITLE for the node."
    (org-roam-get-keyword "TITLE" (org-roam-node-file node)))
  (cl-defmethod org-roam-node-hierarchy ((node org-roam-node))
    "Return the hierarchy for the node."
    (let ((title (org-roam-node-title node))
	  (olp (org-roam-node-olp node))
	  (level (org-roam-node-level node))
	  (filetitle (org-roam-node-filetitle node)))
      (concat
       (if (> level 0) (concat filetitle " > "))
       (if (> level 1) (concat (string-join olp " > ") " > "))
       title))
    ))

(use-package org-roam-bibtex
  :after org-roam)

(use-package org-clock
  :after org
  :ensure org-plus-contrib
  :config
  (setq org-clock-clocked-in-display nil
	org-clock-mode-line-total 'current))

(use-package org-protocol
:after org
:ensure org-plus-contrib)

(use-package org-download
  :after org
  :config
  (setq org-download-method 'directory
	org-image-actual-width nil
	org-download-screenshot-method "screencapture -i %s"
	org-download-display-inline-images 'posframe
	;; disable DOWNLOAD link
	org-download-annotate-function (lambda (_link) "")
	org-download-image-attr-list '("#+ATTR_HTML: :width 70% :align center"))
  (setq-default org-download-image-dir (concat org-directory "images/")))

(use-package toc-org
  :init
  (add-hook 'org-mode-hook 'toc-org-mode))

(use-package ox-hugo
  :after ox)

(use-package org-media-note
  :hook (org-mode .  org-media-note-mode)
  :quelpa (org-media-note :fetcher github :repo "yuchen-lea/org-media-note" :branch "master")
  :config
  (require 'org-attach)
  (setq org-media-note-screenshot-image-dir (concat org-directory "images/org-media/")))

(general-define-key
 :keymaps 'org-mode-map
 "C-c C-r" nil
 "C-c r" 'org-reveal
 "C-s-4" 'org-download-screenshot
 "H-v" 'org-media-note-hydra/body
 "C-c ]" 'org-ref-insert-link)

(general-define-key
 :prefix "C-c C-r"
 "C-d" '(:ignore t :which-key "org-dailies")
 "C-d t" 'org-roam-dailies-goto-today
 "C-d d" 'org-roam-dailies-goto-date
 "C-d p" 'org-roam-dailies-goto-previous-note
 "C-d n" 'org-roam-dailies-goto-next-note
 "f" 'org-roam-node-find)

(general-define-key
 :prefix "H-i"
 :keymaps 'org-mode-map
 "r" 'org-mac-skim-insert-page ;; skim
 "s"  'org-mac-safari-insert-frontmost-url ;; internet
 "f"  'org-mac-finder-insert-selected ;; finder
 "i" 'org-store-link)

(general-define-key
 :keymaps 'org-mode-map
 "M-o" 'reader/goto-pdf-first-page-or-nov-toc
 "M-n" 'reader/scroll-up
 "M-p" 'reader/scroll-down)

(general-define-key
 :keymaps 'nov-mode-map
 "M-n" 'nov-scroll-up
 "M-p" 'nov-scroll-down)

(general-define-key
 :keymaps 'org-mode-map
 :prefix "C-c C-r"
 "r" 'org-roam-buffer-toggle
 "C-i" 'org-roam-node-insert
 "g" 'org-roam-graph
 "i" '(:ignore t :which-key "add property")
 "i a" 'org-roam-alias-add
 "i r" 'org-roam-ref-add
 "i t" 'org-roam-tag-add
 "d" '(:ignore t :which-key "remove property")
 "d a" 'org-roam-alias-remove
 "d r" 'org-roam-ref-remove
 "d t" 'org-roam-tag-remove)
(general-define-key
 :keymaps 'bibtex-mode-map
 "H-b" 'org-ref-bibtex-hydra/body)


(general-define-key
 :keymaps 'org-roam-mode-map
 [mouse-1] 'org-roam-visit-thing)

(use-package ivy
  :defer t
  :init
  (add-hook 'after-init-hook 'ivy-mode)
  (setq ivy-use-virtual-buffers t
	enable-recursive-minibuffers t)
  :general
  (general-define-key
   :keymaps 'ivy-minibuffer-map
   [escape] 'minibuffer-keyboard-quit
   "C-<return>" 'ivy-immediate-done)
  :config
  (meow-leader-define-key
   '("/" . counsel-rg)))

(use-package swiper
  :defer t
  :commands (swiper)
  :init
  (general-define-key
   "C-s" 'counsel-grep-or-swiper))

(use-package counsel
  :hook (ivy-mode . counsel-mode)
  :config
  (meow-leader-define-key
   '("ff" . counsel-find-file)
   '("fb" . counsel-switch-buffer)
   '("fr" . counsel-buffer-or-recentf)))

(use-package all-the-icons-ivy
  :init (add-hook 'after-init-hook 'all-the-icons-ivy-setup))

(use-package wgrep
  :after ivy
  :config
  (setq wgrep-auto-save-buffer t))

(use-package calibredb
  :defer t
  :quelpa (calibredb :fetcher github :repo "chenyanming/calibredb.el" :branch "develop")
  :commands (calibredb)
  :config
  (setq calibredb-size-show t
	;;calibredb-format-all-the-icons t
	calibredb-id-width 4
	calibredb-title-width 40
	calibredb-date-width 0
	calibredb-root-dir private/book-directory
	calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir)
	calibredb-library-alist '(private/book-directory)))

(use-package simpleclip
  :init
  (simpleclip-mode t))

(general-define-key
 "s-q" 'delete-frame)

(use-package company
  :defer t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-idle-delay 0.3
	company-require-match 'never
	company-tooltip-align-annotations t
	company-dabbrev-downcase nil
	company-dabbrev-ignore-case nil
	company-minimum-prefix-length 1)
  (setq company-backend
	'(company-keywords
	  company-elisp
	  company-files
	  company-capf
	  company-yasnippet
	  company-dabbrev-code
	  company-dabbrev))
  :general
  (general-define-key
   :keymaps 'company-active-map
   "<tab>" 'company-complete-selection
   "<RET>" nil
   "<return>" nil
   "C-w" nil
   "C-n" 'company-select-next
   "C-p" 'company-select-previous))

(use-package smartparens
  :hook (prog-mode . smartparens-mode)
  :hook (org-mode . smartparens-mode))

(use-package embrace
  :defer t
  :commands (embrace-add embrace-delete embrace-change embrace-commander)
  :init
  (meow-leader-define-key
   '("sc" . embrace-change)
   '("sd" . embrace-delete)
   '("ss" . embrace-add)))

(use-package yasnippet
  :defer t
  :hook (prog-mode . yas-minor-mode)
  :hook (org-mode . yas-minor-mode))

(use-package yasnippet-snippets
  :defer t
  :hook (yas-minor-mode . yas-reload-all))

(use-package prescient
  :after (ivy company)
  :config
  (setq prescient-filter-method 'regexp))

(use-package ivy-prescient
  :after (prescient counsel)
  :hook (ivy-mode . ivy-prescient-mode)
  :config
  (setq ivy-prescient-retain-classic-highlighting t))

(use-package company-prescient
  :after prescient
  :hook (company-mode . company-prescient-mode))

(use-package avy
  :commands (avy-goto-char-2 avy-goto-line)
  :init
  (meow-leader-define-key
   '("fc" . avy-goto-char-2)
   '("fl" . avy-goto-line))
  :config
  (setq avy-all-windows nil
        avy-background t))

(defun projectile-relevant-known-projects ()
  "Return a list of known projects except the current one (if present)."
  (if (projectile-project-p)

      (->> projectile-known-projects
	   (--reduce-from
	    (if (-contains? (-map 's-downcase acc) (s-downcase it)) acc (cons it acc))
	    (list (abbreviate-file-name (projectile-project-root))))
	   (-sort 'string-lessp))

    projectile-known-projects))

(use-package projectile
  :init
  (add-hook 'after-init-hook 'projectile-mode)
  (setq project-cache-file "~/.emacs.d/projectile.cache"
	project-know-projects-file "~/.emacs.d/projectile-bookmarks.eld"
	projectile-project-search-path '("~/Kenton/")
	projectile-completion-system 'ivy)
  :config
  (projectile-discover-projects-in-search-path)
  (projectile-relevant-known-projects))

(use-package counsel-projectile
  :init
  (add-hook 'after-init-hook 'counsel-projectile-mode)
  (meow-leader-define-key
   '("pf" . counsel-projectile-find-file)
   '("pl" . counsel-projectile-switch-project)))

(use-package magit
  :commands (magit-status magit-blame)
  :init
  (general-define-key
   "C-M-s" 'magit-status
   "C-M-b" 'magit-blame)
  :config
  (general-define-key
   :keymaps 'magit-mode-map
   "s-<return>" 'magit-diff-visit-file-other-window
   "C-c C-k" 'magit-discard
   "x" 'meow-line))

(use-package elixir-mode
  :defer t
  :config
  (add-hook 'elixir-mode-hook
	    (lambda() (add-hook 'before-save-hook 'elixir-format nil t)))

  (defun +reset-mixfmt-args ()
    (let* ((formatter-directory (locate-dominating-file default-directory ".formatter.exs"))
	   (formatter-file (concat formatter-directory ".formatter.exs")))
      (if formatter-directory
	  (setq elixir-format-arguments (list "--dot-formatter" formatter-file))
	(setq elixir-format-arguments nil))))

  (add-hook 'elixir-format-hook #'+reset-mixfmt-args))

(use-package exunit
  :defer t
  :after elixir-mode
  :config
  :commands (exunit-verify-all
	     exunit-verify
	     exunit-verify-all-in-umbrella
	     exunit-verify-single
	     exunit-rerun
	     exunit-toggle-file-and-test)
  :general
  (general-define-key
   :keymaps 'elixir-mode-map
   :keymaps 'exunit-compilation-mode-map
   "C-c C-t a" 'exunit-verify-all
   "C-c C-t t" 'exunit-verify-single
   "C-c C-t b" 'exunit-verify
   "C-c C-t r" 'exunit-rerun
   "C-c C-t f" 'exunit-toggle-file-and-test
   ))

(use-package haskell-mode
  :defer t
  :init
  (add-hook 'haskell-mode-hook 'lsp)
  (add-hook 'haskell-literate-mode-hook 'lsp)
  :config
  (setq haskell-process-type 'stack-ghci))

(use-package lsp-haskell
  :defer t)

(use-package sly
  :defer t
  :init
  (setq inferior-lisp-program "/Users/smartepsh/.asdf/shims/sbcl"
	org-babel-lisp-eval-fn 'sly-eval))

(use-package lsp-mode
  :defer t
  :init
  (setq lsp-keymap-prefix "s-l")
  (add-to-list 'exec-path (concat private/config-directory "elixir-ls"))
  :hook (elixir-mode . lsp)
  :hook (lsp-mode . lsp-enable-which-key-integration)
  :config
  (setq lsp-headerline-breadcrumb-enable nil
	lsp-file-watch-threshold 2000)
  (meow-leader-define-key
   '("." . lsp-find-definition)
   '("," . xref-pop-marker-stack))
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.elixir_ls\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\deps\\'"))

(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
;;(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

(use-package flyspell
  :ensure-system-package hunspell
  :hook (text-mode . flyspell-mode)
  :hook (prog-mode . flyspell-prog-mode)
  :init
  (setenv "LANG" "en_US")
  (setq flyspell-issue-welcome-flag nil)
  :config
  (setq ispell-program-name (executable-find "hunspell")
	ispell-dictionary "en_US"
	ispell-local-dictionary-alist '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8)))
  (global-set-key (kbd "C-c s") 'flyspell-learn-word-at-point)

  (defun flyspell-learn-word-at-point ()
    "Takes the highlighted word at point -- nominally a misspelling -- and inserts it into the personal/private dictionary, such that it is known and recognized as a valid word in the future."
    (interactive)
    (let ((current-location (point))
	  (word (flyspell-get-word)))
      (when (consp word)
	(flyspell-do-correct
	 'save nil
	 (car word)
	 current-location
	 (cadr word)
	 (caddr word)
	 current-location)))))

(use-package flyspell-correct-ivy
  :after flyspell-correct)

(use-package flyspell-correct
  :commands (flyspell-correct-wrapper)
  :init
  (setq flyspell-correct-interface 'flyspell-correct-ivy)
  :general
  (general-define-key
   :keymaps 'flyspell-mode-map
   "C-;" 'flyspell-correct-wrapper
   "C-," nil
   "C-'" 'flyspell-learn-word-at-point))

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
  (meow-leader-define-key
   '("fd" . dired-jump)
   '("fD" . dired-jump-other-window)))

(use-package flycheck
  :defer t
  :init
  (add-hook 'prog-mode-hook 'flycheck-mode)
  (add-hook 'flycheck-mode-hook 'flycheck-posframe-mode))

(use-package flycheck-posframe
  :after flycheck)

(use-package evil-nerd-commenter
  :defer t
  :commands (evilnc-comment-or-uncomment-lines)
  :init
  (general-define-key
   "C-M-c" 'evilnc-comment-or-uncomment-lines))
