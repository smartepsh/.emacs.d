(defun ess-indent-region-as-R-function (beg end)
  (let ((string (replace-regexp-in-string
                 "\"" "\\\\\\&"
                 (replace-regexp-in-string ;; how to avoid this double matching?
                  "\\\\\"" "\\\\\\&" (buffer-substring-no-properties beg end))))
        (buf (get-buffer-create "*ess-command-output*")))
    (ess-force-buffer-current "Process to load into:")
    (ess-command (format "local({oo<-options(keep.source=FALSE);
cat('\n',paste(deparse(parse(text=\"%s\")[[1L]]),collapse='\n'),'\n',sep='')
options(oo)})\n"  string) buf)
    (with-current-buffer buf
      (goto-char (point-max))
      ;; (skip-chars-backward "\n")
      (let ((end (point)))
        (goto-char (point-min))
        (goto-char (1+ (point-at-eol)))
        (setq string (buffer-substring-no-properties (point) end))
        ))
    (delete-region beg end)
    (insert string)
    ))

(use-package ess
  :defer t
  :config
  (add-hook 'ess-r-mode-hook #'(lambda () (set (make-local-variable 'indent-region-function) 'ess-indent-region-as-R-function)))
  (setq ess-eval-visibly nil
        ess-ask-for-ess-directory nil
        ess-local-process-name "*R*"
        comint-scroll-to-bottom-on-input t
        comint-scroll-to-bottom-on-output t
        comint-move-point-for-output t)
  :general
  (local-leader
    :keymaps 'ess-r-mode-map
    "e" '(ess-R-describe-object-at-point-commands :which-key "describe object")
    "b" '(ess-build-tags-for-directory :which-key "build tags")
    "r" '(R :which-key "R"))
  (general-define-key
   :keymaps 'ess-r-mode-map
   "s-<return>" 'ess-eval-region-or-line-and-step))

(provide 'init-r)
