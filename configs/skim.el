;;; Public Domain by Stian Haklev 2014
;;; heavily under construction, mostly built for my own use, but
;;; feel free to improve and make more general
;;; I keep all my academic PDFs in the same directory, and want special
;;; handling for them - eventually I'll check if the PDF is in that dir
;;; and if not, I'll insert the whole path in the org-link etc.

;;; based on https://github.com/houshuang/skim-emacs/blob/master/skim.el

(require 'org-mac-link)

(defun skim-page (&optional offset)
  (interactive)
  (when (not offset) (setq offset 1))
  (do-applescript (format "
tell document 1 of application \"Skim\" to set a to index of current page
tell document 1 of application \"Skim\" to go to page (a + %d)
a" offset)))

(defun skim-page-absolute (offset)
  (interactive)
  (do-applescript (format "
tell document 1 of application \"Skim\" to set a to index of current page
tell document 1 of application \"Skim\" to go to page %d
a" offset)))

(defun skim-goto (page)
  (interactive "nPDF Page: ")
  (skim-page-absolute page))

;; (defun skim-get-highlights ()
;;   (interactive)
;;   (insert (do-applescript "
;; tell application \"Skim\"
;; 	set pageNotes to notes of page 3 of document 1
;; 	set out to \"\"
;; 	repeat with i in pageNotes
;; 		set txt to get text of i
;; 		set out to out & txt & \"\n\n\"
;; 	end repeat
;; end tell
;; out")))

(defun skim-current-page ()
  (interactive)
  (skim-page 0))

(defun skim-current-file ()
  (interactive)
  (do-applescript "tell document 1 of application \"Skim\" to set a to name
a"))

(defun skim-next-page ()
  (interactive)
  (skim-page 1))

(defun skim-prev-page ()
  (interactive)
  (skim-page -1))

(defun skim-kill-other-windows ()
  (interactive)
  (do-applescript "
tell application \"Skim\"
        set mainID to id of front window
        -- insert your code
        close (every window whose id ≠ mainID)
end tell"))

(defun open-link-in-skim ()
  (interactive)
  (let ((link (org-element-context)))
    (if (string-equal (org-element-property :type link) "skim")
        (progn
          (org-mac-skim-open (org-element-property :path link))
          (skim-kill-other-windows)
          (sleep-for 0 100)
          (do-applescript "tell application \"Emacs\" to activate"))
      (message "It's not a skim link !!!"))))


(defun skim-insert-book-link ()
  (interactive)
  (insert (skim-book-link)))

(defun skim-insert-page-link ()
  (interactive)
  (insert (skim-page-link-without-book-name)))

(defun skim-book-link ()
  "get book link into org with page 1 and description don't contain page number"
  (let* ((link-and-descr (as-get-skim-page-link))
         (split-link (split-string link-and-descr "::split::"))
         (link (car split-link))
         (description (cadr split-link))
         (book-link (concat (link-to-book link) "::1"))
         (book-name (book-name description))
         (org-link))
    (when (not (string= link ""))
      (setq org-link (org-link-make-string book-link book-name)))
    (kill-new org-link)
    org-link))

(defun skim-page-link-without-book-name ()
  "only get page link with page number as description (without book name)"
  (let* ((link-and-descr (as-get-skim-page-link))
         (split-link (split-string link-and-descr "::split::"))
         (link (car split-link))
         (description (cadr split-link))
         (page-number (concat "p." (page-number description)))
         (org-link))
    (when (not (string= link ""))
      (setq org-link (org-link-make-string link page-number)))
    (kill-new org-link)
    org-link))

(defun link-to-book (link)
  (s-join "" (reverse (cdr (reverse (split-string link "::"))))))

(defun page-number (description)
  (car (reverse (split-string description ", p\\."))))

(defun book-name (description)
  (s-join "" (reverse (cdr (reverse (split-string description ", p\\."))))))

(provide 'skim)
