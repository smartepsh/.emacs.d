;;; Public Domain by Stian Haklev 2014
    ;;; heavily under construction, mostly built for my own use, but
    ;;; feel free to improve and make more general
    ;;; I keep all my academic PDFs in the same directory, and want special
    ;;; handling for them - eventually I'll check if the PDF is in that dir
    ;;; and if not, I'll insert the whole path in the org-link etc.

    ;;; based on https://github.com/houshuang/skim-emacs/blob/master/skim.el

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

(defun skim-current-page ()
  (interactive)
  (skim-page 0))

(defun skim-current-file ()
  (interactive)
  (do-applescript "tell document 1 of application \"Skim\" to set a to name a"))

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

(provide 'skim)
