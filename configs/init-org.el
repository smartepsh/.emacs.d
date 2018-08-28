(use-package org
  :ensure org-plus-contrib
  :ensure-system-package terminal-notifier
  :pin org-cn
  :defer t
  :config
  (nconc org-modules '(org-id org-protocol))
  (defun org-capture-screenshot ()
    "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
    (interactive)
    (org-display-inline-images)
    (setq filename
	  (concat
	   (make-temp-name
	    (concat (file-name-nondirectory (buffer-file-name))
		    "_imgs/"
		    (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
    (unless (file-exists-p (file-name-directory filename))
      (make-directory (file-name-directory filename)))
					; take screenshot
    (if (eq system-type 'darwin)
	(call-process "screencapture" nil nil nil "-i" filename))
    (if (eq system-type 'gnu/linux)
	(call-process "import" nil nil nil filename))
					; insert into file if correctly taken
    (if (file-exists-p filename)
	(insert (concat "[[file:" filename "]]"))))
  (defun notify-osx (title meassage)
    (call-process "terminal-notifier"
		  nil 0 nil
		  "-group" "Emacs"
		  "-title" title
		  "-sender" "org.gnu.Emacs"
		  "-mesage" message
		  "-activate" "org.gnu.Emacs"))
  :general
  (common-leader
    "on" 'org-noter))

(use-package org-pomodoro
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
	      (notify-osx "Pomodoro Killed!" "One des not simply kill a pomodoro!"))))

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
    "cc" 'org-mac-chrome-insert-frontmost-url
    "ck" 'org-mac-skim-insert-page
    "cf" 'org-mac-finder-insert-selected))

(use-package ob-elixir
  :after org
  :init
  (add-to-list 'org-babel-load-languages '(elixir . t)))

(use-package nov
  :mode ("\\.epub\\'" . nov-mode)
  :general
  ;; disable special "h" key action
  (general-define-key
   :keymaps '(nov-mode-map)
   "h" nil)
  (clear-spc :keymaps '(nov-mode-map))
  (local-leader
    :keymaps 'nov-mode-map
    "n" 'nov-next-document
    "p" 'nov-previous-document
    "m" 'nov-goto-toc
    "," 'nov-brower-url
    :keymaps 'org-noter-doc-mode-map
    "i" 'org-noter-insert-note
    "I" 'org-noter-insert-precise-note
    "s" '(:ignore t :which-key "org-noter-sync")
    "sC" 'org-noter-sync-current-page-or-chapter
    "sc" 'org-noter-sync-current-note
    "sN" 'org-noter-sync-next-page-or-chapter
    "sn" 'org-noter-sync-next-note
    "sP" 'org-noter-sync-prev-page-or-chapter
    "sp" 'org-noter-sync-prev-note))

(use-package org-noter
  :commands org-noter
  :hook (org-mode . org-noter-notes-mode)
  :init
  (setq org-noter-always-create-frame nil)
  :general
  (local-leader
    :keymaps 'org-noter-notes-mode-map
    "s" '(:ignore t :which-key "org-noter-sync")
    "sC" 'org-noter-sync-current-page-or-chapter
    "sc" 'org-noter-sync-current-note
    "sN" 'org-noter-sync-next-page-or-chapter
    "sn" 'org-noter-sync-next-note
    "sP" 'org-noter-sync-prev-page-or-chapter
    "sp" 'org-noter-sync-prev-note))

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
;;   (defun my-as-get-skim-page-link ()
;;     (do-applescript
;;      (concat
;;       "tell application \"Skim\"\n"
;;       "set theDoc to front document\n"
;;       "set theTitle to (name of theDoc)\n"
;;       "set thePath to (path of theDoc)\n"
;;       "set thePage to (get index for current page of theDoc)\n"
;;       "set theSelection to selection of theDoc\n"
;;       "set theContent to (contents of (get text for theSelection))\n"
;;       "try\n"
;;       "    set theNote to active note of theDoc\n"
;;       "end try\n"
;;       "if theNote is not missing value then\n"
;;       "    set theContent to contents of (get text for theNote)\n"
;;       "    set theNotePage to get page of theNote\n"
;;       "    set thePage to (get index for theNotePage)\n"
;;       "    set theNoteIndex to (get index for theNote on theNotePage)\n"
;;       "else\n"
;;       "    if theContent is missing value then\n"
;;       "        set theContent to theTitle & \", p. \" & thePage\n"
;;       "        set theNoteIndex to 0\n"
;;       "    else\n"
;;       "        tell theDoc\n"
;;       "            set theNote to make new note with data theSelection with properties {type:highlight note}\n"
;;       "            set active note of theDoc to theNote\n"
;;       "            set text of theNote to (get text for theSelection)\n"
;;       "            set theNotePage to get page of theNote\n"
;;       "            set thePage to (get index for theNotePage)\n"
;;       "            set theNoteIndex to (get index for theNote on theNotePage)\n"
;;       "            set theContent to contents of (get text for theNote)\n"
;;       "        end tell\n"
;;       "    end if\n"
;;       "end if\n"
;;       "set theLink to \"skim://\" & thePath & \"::\" & thePage & \";;\" & theNoteIndex & "
;;       "\"::split::\" & theContent\n"
;;       "end tell\n"
;;       "return theLink as string\n")))
;;   (defun my-as-get-skim-bibtex-key ()
;;     (let* ((name (do-applescript
;; 		  (concat
;; 		   "tell application \"Skim\"\n"
;; 		   "set theDoc to front document\n"
;; 		   "set theTitle to (name of theDoc)\n"
;; 		   "end tell\n"
;; 		   "return theTitle as string\n")))
;; 	   (key (when (string-match "\"\\(.+\\).pdf\"" name) (match-string 1 name))))
;;       key)
;;     )
;;   (defun my-as-get-skim-page ()
;;     (let* ((page (do-applescript
;; 		  (concat
;; 		   "tell application \"Skim\"\n"
;; 		   "set theDoc to front document\n"
;; 		   "set thePage to (get index for current page of theDoc)\n"
;; 		   "end tell\n"
;; 		   "return thePage as integer\n"))))
;;       page))
;;   (defun my-as-clean-skim-page-link (link)
;;     (let* ((link (replace-regexp-in-string "\n" " " link))
;; 	   (link (replace-regexp-in-string "- " " " link)))
;;       link))
;;   (defun my-org-mac-skim-get-page ()
;;     (interactive)
;;     (message "Applescript: Getting Skim page link...")
;;     (org-mac-paste-applescript-links (my-as-clean-skim-page-link (my-as-get-skim-page-link))))
;;   (defun my-org-mac-skim-insert-page ()
;;     (interactive)
;;     (insert (my-org-mac-skim-get-page)))
;;   (defun my-org-move-point-to-capture ()
;;     (cond ((org-at-heading-p) (org-beginning-of-line))
;; 	  (t (org-previous-visible-heading 1))))
;;   (defun my-org-ref-find-entry-in-notes (key)
;;     "Find or create bib note for KEY"
;;     (let* ((entry (bibtex-completion-get-entry key)))
;;       (widen)
;;       (goto-char (point-min))
;;       (unless (derived-mode-p 'org-mode)
;; 	(error
;; 	 "Target buffer \"%s\" for jww/find-journal-tree should be in Org mode"
;; 	 (current-buffer)))
;;       (let* ((headlines (org-element-map
;; 			    (org-element-parse-buffer)
;; 			    'headline 'identity))
;; 	     (keys (mapcar
;; 		    (lambda (hl) (org-element-property :CUSTOM_ID hl))
;; 		    headlines)))
;; 	;; put new entry in notes if we don't find it.
;; 	(if (-contains? keys key)
;; 	    (progn
;; 	      (org-open-link-from-string (format "[[#%s]]" key))
;; 	      (lambda nil
;; 		(cond ((org-at-heading-p)
;; 		       (org-beginning-of-line))
;; 		      (t (org-previous-visible-heading 1))))
;; 	      )
;; 	  ;; no entry found, so add one
;; 	  (goto-char (point-max))
;; 	  (insert (org-ref-reftex-format-citation
;; 		   entry (concat "\n" org-ref-note-title-format)))
;; 	  (mapc (lambda (x)
;; 		  (save-restriction
;; 		    (save-excursion
;; 		      (funcall x))))
;; 		org-ref-create-notes-hook)
;; 	  (org-open-link-from-string (format "[[#%s]]" key))
;; 	  (lambda nil
;; 	    (cond ((org-at-heading-p)
;; 		   (org-beginning-of-line))
;; 		  (t (org-previous-visible-heading 1))))
;; 	  ))
;;       ))
;;   (defun my-org-move-point-to-capture-skim-annotation ()
;;     (let* ((keystring (my-as-get-skim-bibtex-key)))
;;       (my-org-ref-find-entry-in-notes keystring)
;;       ))
;;
;;   (add-hook 'org-capture-prepare-finalize-hook #'(lambda () (my-as-set-skim-org-link (org-id-get-create))))
;;   (defun my-as-set-skim-org-link (id)
;;     (do-applescript (concat
;; 		     "tell application \"Skim\"\n"
;; 		     "set runstatus to \"not set\"\n"
;; 		     "set theDoc to front document\n"
;; 		     "try\n"
;; 		     "    set theNote to active note of theDoc\n"
;; 		     "end try\n"
;; 		     "if theNote is not missing value then\n"
;; 		     "    set newText to text of theNote\n"
;; 		     "    set startpoint to  (offset of \"org-id:{\" in newtext)\n"
;; 		     "    set endpoint to  (offset of \"}:org-id\" in newtext)\n"
;; 		     "    if (startpoint is equal to endpoint) and (endpoint is equal to 0) then\n"
;; 		     "        set newText to text of theNote & \"\norg-id:{\" & "
;; 		     (applescript-quote-string id)
;; 		     " & \"}:org-id\"\n"
;; 		     "        set text of theNote to newText\n"
;; 		     "        return \"set success\"\n"
;; 		     "    end if\n"
;; 		     "end if\n"
;; 		     "end tell\n"
;; 		     "return \"unset\"\n"
;; 		     )))
;;   (defun applescript-quote-string (argument)
;;     "Quote a string for passing as a string to AppleScript."
;;     (if (or (not argument) (string-equal argument ""))
;; 	"\"\""
;;       ;; Quote using double quotes, but escape any existing quotes or
;;       ;; backslashes in the argument with backslashes.
;;       (let ((result "")
;; 	    (start 0)
;; 	    end)
;; 	(save-match-data
;; 	  (if (or (null (string-match "[^\"\\]" argument))
;; 		  (< (match-end 0) (length argument)))
;; 	      (while (string-match "[\"\\]" argument start)
;; 		(setq end (match-beginning 0)
;; 		      result (concat result (substring argument start end)
;; 				     "\\" (substring argument end (1+ end)))
;; 		      start (1+ end))))
;; 	  (concat "\"" result (substring argument start) "\""))))))

(use-package evil-org
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
	    (lambda ()
	      (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))


(provide 'init-org)
