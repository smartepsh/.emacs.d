(require 'skim)

(setq org-directory "~/Qsync/notes/")
(setq org-agenda-file (concat org-directory "agenda.org"))

(use-package org
  :ensure org-plus-contrib
  ;; :ensure-system-package terminal-notifier
  :pin org
  :defer t
  :config
  ;;; auto display inline images on Org TAB cycle expand headlines.
  (add-hook 'org-cycle-hook #'org-display-subtree-inline-images)
  (setq org-todo-keywords '((sequence "TODO(t)" "VERIFY(v)" "|" "DONE(d)" "DELEGATED(g)" "CANCELED(c)"))
        org-default-notes-file (concat org-directory "default.org")
        org-archive-location (concat org-directory "Archived/" "%s_archive::")
        org-log-done 'time)
  (nconc org-modules '(org-id org-protocol))
  (setq org-refile-targets '((org-agenda-files :maxlevel . 3))
        org-refile-use-outline-path 'file
        org-outline-path-complete-in-steps nil
        org-refile-allow-creating-parent-nodes 'confirm)
  :general
  (common-leader
    "oo" 'open-orgs)
  (general-nmap
    :keymaps 'org-mode-map
    "C-s-n" 'skim-next-page
    "C-s-p" 'skim-prev-page)
  (local-leader
    :keymaps 'org-mode-map
    "A" 'org-attach
    "a" 'org-agenda
    "t" 'org-todo
    "sa" 'org-archive-subtree
    "ss" 'org-sparse-tree
    "sr" 'org-refile
    "bb" 'org-switchb
    "p" '(:ignore t :which-key "priorities")
    "pp" 'org-priority
    "pu" 'org-priority-up
    "pd" 'org-priority-down
    "d" '(:ignore t :which-key "datetimes")
    "dt" 'org-time-stamp
    "dT" 'org-time-stamp-inactive
    "ds" 'org-schedule
    "dd" 'org-deadline
    "i" '(:ignore t :which-key "inserts")
    "if" 'org-footnote-new
    "it" 'org-set-tags
    "ip" 'org-set-property
    "is" 'org-insert-structure-template
    "l" '(:ignore t :which-key "links")
    "lt" 'org-toggle-link-display
    "ls" 'org-store-link
    "lI" 'org-insert-last-stored-link
    "li" 'org-insert-link
    "ll" 'org-open-at-point
    "lb" 'org-mark-ring-goto
    "k" '(:ignore t :which-key "skim")
    "kn" 'skim-next-page
    "kp" 'skim-prev-page
    "ki" 'skim-insert-page-link
    "kb" 'skim-insert-book-link
    "ko" 'open-link-in-skim
    "kg" 'skim-goto))

(use-package org-agenda
  :ensure org-plus-contrib
  :commands (org-agenda-list
             org-agenda
             org-agenda-to-appt)
  :init
  (setq org-agenda-files (directory-files-recursively org-directory "\.org$"))
  (setq org-agenda-diary-file (concat org-directory "diary.org")))

(use-package org-clock
  :after org
  :ensure org-plus-contrib
  :config
  (setq org-clock-clocked-in-display nil
        org-clock-mode-line-total 'current))

(use-package org-download
  :after org
  :config
  (setq org-download-method 'attach
        org-download-screenshot-method "screencapture -i %s"
        org-download-display-inline-images 'posframe
        ;; disable DOWNLOAD link
        org-download-annotate-function (lambda (_link) "")
        org-download-image-attr-list '("#+ATTR_HTML: :width 70% :align center")
        org-download-image-dir (concat org-directory "images/"))
  :general
  (general-define-key
   :keymaps 'org-mode-map
   "C-s-4" 'org-download-screenshot)
  (local-leader
    :keymaps 'org-mode-map
    "iv" 'org-download-clipboard))


(use-package toc-org
  :commands (toc-org-markdown-follow-thing-at-point)
  :init
  (add-hook 'org-mode-hook 'toc-org-mode))

(use-package evil-org
  :after org
  :init
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

;;;;;;;;;;;;;;;;;;custom functions;;;;;;;;;;;;;;

(defun open-orgs()
  (interactive)
  (if (buffer-live-p "default.org")
      (pop-to-buffer "default.org")
    (find-file (concat org-directory "default.org"))))

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

;; (use-package org-pomodoro
;;   :commands org-pomodoro
;;   :config
;;   (add-hook 'org-pomodoro-finished-hook
;;             (lambda()
;;               (notify-osx "Pomodoro completed!" "Time for a break.")))
;;   (add-hook 'org-pomodoro-break-finished-hook
;;             (lambda()
;;               (notify-osx "Pomodoro Short Break Finished!" "Ready for Another?")))
;;   (add-hook 'org-pomodoro-long-break-finished-hook
;;             (lambda()
;;               (notify-osx "Pomodoro Long Break Finished!" "Ready for Another?")))
;;   (add-hook 'org-pomodoro-killed-hook
;;             (lambda()
;;               (notify-osx "Pomodoro Killed!" "One does not simply kill a pomodoro!"))))

(use-package org-capture
  :after org
  :ensure org-plus-contrib)

(use-package org-mac-link
  :ensure org-plus-contrib
  :commands (org-mac-skim-insert-page
             org-mac-chrome-insert-frontmost-url
             org-mac-finder-insert-selected)
  :general
  (local-leader
    :keymaps 'org-mode-map
    "c" '(:ignore t :which-key "capture")
    "cc" 'org-mac-safari-insert-frontmost-url
    "ck" 'org-mac-skim-insert-page
    "cf" 'org-mac-finder-insert-selected))

(use-package ob-elixir
  :after org
  :init
  (add-to-list 'org-babel-load-languages '(elixir . t)))

;; (use-package nov
;;   :mode ("\\.epub\\'" . nov-mode)
;;   :general
;;   ;; disable special "h" key action
;;   (general-define-key
;;    :keymaps '(nov-mode-map)
;;    "h" nil)
;;   (clear-spc :keymaps '(nov-mode-map))
;;   (local-leader
;;     :keymaps 'nov-mode-map
;;     "n" 'nov-next-document
;;     "p" 'nov-previous-document
;;     "m" 'nov-goto-toc
;;     "," 'nov-brower-url
;;     :keymaps 'org-noter-doc-mode-map
;;     "i" 'org-noter-insert-note
;;     "I" 'org-noter-insert-precise-note
;;     "s" '(:ignore t :which-key "org-noter-sync")
;;     "sC" 'org-noter-sync-current-page-or-chapter
;;     "sc" 'org-noter-sync-current-note
;;     "sN" 'org-noter-sync-next-page-or-chapter
;;     "sn" 'org-noter-sync-next-note
;;     "sP" 'org-noter-sync-prev-page-or-chapter
;;     "sp" 'org-noter-sync-prev-note))

;; (use-package org-noter
;;   :commands org-noter
;;   :hook (org-mode . org-noter-notes-mode)
;;   :init
;;   (setq org-noter-always-create-frame nil)
;;   :general
;;   (local-leader
;;     :keymaps 'org-noter-notes-mode-map
;;     "s" '(:ignore t :which-key "org-noter-sync")
;;     "sC" 'org-noter-sync-current-page-or-chapter
;;     "sc" 'org-noter-sync-current-note
;;     "sN" 'org-noter-sync-next-page-or-chapter
;;     "sn" 'org-noter-sync-next-note
;;     "sP" 'org-noter-sync-prev-page-or-chapter
;;     "sp" 'org-noter-sync-prev-note))

;; (use-package calibre-mode
;;   :quelpa (calibre-mode :fetcher github :repo "smartepsh/calibre-mode")
;;   :commands (calibre-list calibre-find)
;;   :init
;;   (setq sql-sqlite-program "/usr/bin/sqlite3"
;; 	calibre-root-dir (expand-file-name "~/onedrive/calibre")
;; 	calibre-db (concat calibre-root-dir "/metadata.db")))

;; (use-package org-ref
;;   :after org
;;   :init
;;   (setq org-capture-templates (quote (("SA" "Skim Annotation" entry
;; 				       (file+function "~/onedrive/kenton/emacs.org" my-org-move-point-to-capture-skim-annotation)
;; 				       "* %^{Logging for...} :skim_annotation:read:literature:
;; :PROPERTIES:
;; :Created: %U
;; :CITE: %(my-as-get-skim-bibtex-key)
;; :SKIM_NOTE: %(my-org-mac-skim-get-page)
;; :SKIM_PAGE: %(my-as-get-skim-page)
;; :END:
;; %i
;; %?" :prepend f :empty-lines 1))))
;;
;;   ;; (with-eval-after-load 'org-ref-ivy
;;   (org-link-set-parameters "skim" :follow #'my-org-mac-skim-open)
;;   (defun my-org-mac-skim-open (uri)
;;     "Visit page of pdf in Skim"
;;     (let* ((note (when (string-match ";;\\(.+\\)\\'" uri) (match-string 1 uri)))
;; 	   (page (when (string-match "::\\(.+\\);;" uri) (match-string 1 uri)))
;; 	   (document (substring uri 0 (match-beginning 0))))
;;       (do-applescript
;;        (concat
;; 	"tell application \"Skim\"\n"
;; 	"activate\n"
;; 	"set theDoc to \"" document "\"\n"
;; 	"set thepage to " page "\n"
;; 	"set theNote to " note "\n"
;; 	"open theDoc\n"
;; 	"go document 1 to page thePage of document 1\n"
;; 	"if theNote is not 0\n"
;; 	"    go document 1 to item theNote of notes of page thePage of document 1\n"
;; 	"    set active note of document 1 to item theNote of notes of page thePage of document 1\n"
;; 	"end if\n"
;; 	"end tell"))))
;;   (defadvice org-capture-finalize
;;       (after org-capture-finalize-after activate)
;;     "Advise capture-finalize to close the frame"
;;     (if (equal "SA" (org-capture-get :key))
;; 	(do-applescript "tell application \"Skim\"\n    activate\nend tell")))
;; (use-package anki-editor
;;   :after org
;;   :config
;;   (anki-editor-mode)
;;   :general
;;   (local-leader
;;     :keymaps 'org-mode-map
;;     "kap" 'anki-editor-push-notes
;;     "kai" 'anki-editor-insert-note))

;; (use-package grip-mode
;;   :hook ((markdown-mode org-mode) . grip-mode)
;;   :init
;;   :config
;;   (setq grip-preview-use-webkit t
;;         grip-github-user "smartepsh"
;;         grip-github-password "dd5918431926fa3d62612aeb208e9d7f1e45b7aa"
;;         grip-update-after-change nil))

;; (use-package ox-gfm)

;; (defun notify-osx (title message)
;;   (call-process "terminal-notifier"
;;                 nil 0 nil
;;                 "-group" "Emacs"
;;                 "-title" title
;;                 "-sender" "org.gnu.Emacs"
;;                 "-mesage" message
;;                 "-activate" "org.gnu.Emacs"))
(provide 'init-org)
