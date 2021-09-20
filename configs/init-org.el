(require 'skim)
;; (require 'scimax)

(defun org-refresh-agenda-files ()
  (interactive)
  (setq org-agenda-files (directory-files (concat org-directory "journal/"))))

(setq org-directory  (file-truename "~/kenton-base/"))
(setq bookmark-file (concat org-directory "bookmarks.org"))

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

(defun open-bookmarks ()
  (interactive)
  (if (buffer-live-p "bookmarks.org")
      (pop-to-buffer "bookmarks.org")
    (find-file bookmark-file)))

(use-package org
  :ensure org-plus-contrib
  ;; :ensure-system-package terminal-notifier
  :pin org
  :defer t
  :init
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (elixir . t)
     (org . t)
     (R . t)))
  :config
  ;;; auto display inline images on Org TAB cycle expand headlines.
  ;; (add-hook 'org-mode-hook 'scimax-src-keymap-mode)
  (add-hook 'org-cycle-hook #'org-display-subtree-inline-images)
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
        org-confirm-babel-evaluate nil)
  ;; refresh cache when emacs idle 5 mins
  (run-with-idle-timer 300 t (lambda ()
                               (org-refile-cache-clear)
                               ;; (org-refile-get-targets)
                               (org-roam-db-sync)))
  :general
  (common-leader
    "ob" 'open-bookmarks
    "oa" 'org-agenda)
  (general-define-key
   :keymaps 'org-mode-map
   "C-s-n" 'skim-next-page
   "C-s-p" 'skim-prev-page)
  (local-leader
    :keymaps 'org-mode-map
    "A" 'org-attach
    "t" 'org-todo
    "sa" 'org-archive-subtree
    "ss" 'org-sparse-tree
    "bb" 'org-switchb
    "a" '(:ignore t :which-key "agenda")
    "aa" 'org-agenda
    "as" 'org-schedule
    "ad" 'org-deadline
    "p" '(:ignore t :which-key "priorities")
    "pp" 'org-priority
    "pu" 'org-priority-up
    "pd" 'org-priority-down
    "ph" 'org-toggle-properties
    "d" '(:ignore t :which-key "datetimes")
    "dt" 'org-time-stamp
    "dT" 'org-time-stamp-inactive
    "i" '(:ignore t :which-key "inserts")
    "if" 'org-footnote-new
    "it" 'org-set-tags-command
    "ip" 'org-set-property
    "is" 'org-insert-structure-template
    "il" 'org-insert-link
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
  (org-refresh-agenda-files))

(use-package org-clock
  :after org
  :ensure org-plus-contrib
  :config
  (setq org-clock-clocked-in-display nil
        org-clock-mode-line-total 'current))

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
  (setq-default org-download-image-dir (concat org-directory "images/"))
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

(use-package org-pomodoro
  :commands org-pomodoro
  :config
  (add-hook 'org-pomodoro-finished-hook
            (lambda()
              (notify-osx "Pomodoro completed!" "Time for a break.")))
  (add-hook 'org-pomodoro-break-finished-hook
            (lambda()
              (notify-osx "Pomodoro Short Break Finished!" "Ready for Another?")))
  (add-hook 'org-pomodoro-long-break-finished-hook
            (lambda()
              (notify-osx "Pomodoro Long Break Finished!" "Ready for Another?")))
  (add-hook 'org-pomodoro-killed-hook
            (lambda()
              (notify-osx "Pomodoro Killed!" "One does not simply kill a pomodoro!"))))

(use-package org-capture
  :after org
  :ensure org-plus-contrib)

(use-package org-protocol
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

(use-package ob-elixir :after org)

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

(defun notify-osx (title message)
  (call-process "terminal-notifier"
                nil 0 nil
                "-group" "Emacs"
                "-title" title
                "-sender" "org.gnu.Emacs"
                "-mesage" message
                "-activate" "org.gnu.Emacs"))

(use-package org-roam
  :hook (after-init . org-roam-setup)
  :init
  (setq org-roam-v2-ack t
        org-roam-directory org-directory
        org-roam-db-gc-threshold most-positive-fixnum
        org-roam-db-location (concat org-directory "org-roam.db")
        org-roam-dailies-directory "journal/"
        )

  (require 'org-roam-protocol)
  :config
  (setq org-roam-node-display-template "${hierarchy:*}
${tags:20}")
  (setq org-roam-completion-everywhere t)
  ;; (setq org-roam-completion-system 'ivy)
  (setq org-roam-capture-ref-templates
        '(("b" "Bookmark" plain "%?\n*** ${title}\n:PROPERTIES:\n:ID: %(org-id-new)\n:ROAM_REFS: ${ref}\n:ROAM_EXCLUDE: t\n:END:" :if-new (file+olp "%(symbol-value 'bookmark-file)" ("Uncategorized")) :immediate-finish t :unnarrowed t :empty-lines-after 1))) ;;
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
    )
  :general
  (common-leader
    "r" '(:ignore t :which-key "roam")
    "rr" 'org-roam-buffer-toggle
    "rf" 'org-roam-node-find
    ;; "rs" 'org-roam-server-mode
    "ri" 'org-roam-node-insert
    "re" 'org-roam-refile)
  (general-nmap
    :keymaps 'org-roam-mode-map
    [mouse-1] 'org-roam-visit-thing))

;; (defun my-old-carryover (old_carryover)
;;   (save-excursion
;;     (let ((matcher (cdr (org-make-tags-matcher org-journal-carryover-items))))
;;       (dolist (entry (reverse old_carryover))
;;         (save-restriction
;;           (narrow-to-region (car entry) (cadr entry))
;;           (goto-char (point-min))
;;           (org-scan-tags '(lambda ()
;;                             (org-set-tags ":carried:"))
;;                          matcher org--matcher-tags-todo-only))))))

;; (use-package org-journal
;;   :defer t
;;   :init
;;   (setq org-journal-enable-agenda-integration t
;;         org-journal-handle-old-carryover 'my-old-carryover)
;;   :config
;;   (setq org-journal-dir (concat org-directory "weekly/")
;;         org-journal-file-format "%Y%m%d-%V"
;;         org-journal-file-type 'weekly
;;         org-journal-find-file 'find-file
;;         org-extend-today-until 0
;;         org-icalendar-store-UID t)
;;   ;; org-icalendar-include-todo "all"
;;   ;; org-icalendar-combined-agenda-file (concat org-journal-dir "org-journal.ics"))
;;   :general
;;   (local-leader
;;     :keymaps 'org-journal-mode-map
;;     "j" '(:ignore t :which-key "journal")
;;     "jj" 'org-journal-new-entry
;;     "jn" 'org-journal-next-entry
;;     "jp" 'org-journal-previous-entry
;;     "jv" 'org-journal-schedule-view))

;; (use-package org-roam-server
;;   :defer t
;;   :commands (org-roam-server-mode)
;;   :config
;;   (setq org-roam-server-host "127.0.0.1"
;;         org-roam-server-port 8080
;;         org-roam-server-authenticate nil
;;         org-roam-server-export-inline-images t
;;         org-roam-server-serve-files nil
;;         org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
;;         org-roam-server-network-poll t
;;         org-roam-server-network-arrows nil
;;         org-roam-server-network-label-truncate t
;;         org-roam-server-network-label-truncate-length 60
;;         org-roam-server-network-label-wrap-length 20))

(provide 'init-org)
