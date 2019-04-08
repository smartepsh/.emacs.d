(setq scheme-program-name "mit-scheme")

(local-leader
  :keymaps 'scheme-mode-map
  "sr" 'scheme-send-region
  "sd" 'scheme-send-definition
  "," 'scheme-send-last-sexp
  "r" 'run-scheme
  )

(local-leader
  :keymaps 'inferior-scheme-mode-map
  "l" 'scheme-load-file
  "c" 'comint-clear-buffer
  "q" 'close-scheme
  )

(defun close-scheme ()
  (interactive)
  (if (get-buffer-process (current-buffer))
      (progn
	(set-process-query-on-exit-flag (get-buffer-process (current-buffer)) nil)
	(kill-current-buffer))))

(provide 'init-scheme)
