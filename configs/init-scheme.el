(setq scheme-program-name "mit-scheme")

(local-leader
  :keymaps 'scheme-mode-map
  "sr" 'scheme-send-region
  "sl" '+scheme-send-line
  "sd" 'scheme-send-definition
  "ss" '+scheme-send-last-sexp
  "," '+scheme-send-line
  "r" '+run-scheme-split
  "c" '+clear-scheme-buffer
  )

(local-leader
  :keymaps 'inferior-scheme-mode-map
  "l" 'scheme-load-file
  "c" 'comint-clear-buffer
  "q" '+close-scheme
  )

(defun +close-scheme ()
  (interactive)
  (if (get-buffer-process (current-buffer))
      (progn
	(set-process-query-on-exit-flag (get-buffer-process (current-buffer)) nil)
	(kill-buffer-and-window))))

(defun +run-scheme-split ()
  (interactive)
  (if (get-buffer "*scheme*")
      (display-buffer "*scheme*")
    (split-window-horizontally)
    (other-window 1)
    (run-scheme scheme-program-name)
    (other-window 1)))

(defun +scheme-send-last-sexp ()
  (interactive)
  (right-char)
  (scheme-send-last-sexp)
  (backward-char)
  )

(defun +scheme-send-line ()
  (interactive)
  (scheme-send-region (line-beginning-position) (line-end-position)))

(defun +clear-scheme-buffer ()
  (interactive)
  (switch-to-buffer "*scheme*")
  (comint-clear-buffer)
  (switch-to-prev-buffer))

(provide 'init-scheme)
