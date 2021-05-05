;; (defun scimax-add-keymap-to-src-blocks (limit)
;;   "Add keymaps to src-blocks defined in `scimax-src-block-keymaps'."
;;   (let ((case-fold-search t)
;;         lang)
;;     (while (re-search-forward org-babel-src-block-regexp limit t)
;;       (let ((lang (match-string 2))
;;             (beg (match-beginning 0))
;;             (end (match-end 0)))
;;         (if (assoc (org-no-properties lang) scimax-src-block-keymaps)
;;             (progn
;;               (add-text-properties
;;                beg end `(local-map ,(cdr (assoc
;;                                           (org-no-properties lang)
;;                                           scimax-src-block-keymaps))))
;;               (add-text-properties
;;                beg end `(cursor-sensor-functions
;;                          ((lambda (win prev-pos sym)
;;                             ;; This simulates a mouse click and makes a menu change
;;                             (org-mouse-down-mouse nil)))))))))))

;; (defun scimax-spoof-mode (orig-func &rest args)
;;   "Advice function to spoof commands in org-mode src blocks.
;; It is for commands that depend on the major mode. One example is
;; `lispy--eval'."
;;   (if (org-in-src-block-p)
;;       (let ((major-mode (intern (format "%s-mode" (first (org-babel-get-src-block-info))))))
;;         (apply orig-func args))
;;     (apply orig-func args)))

;; (define-minor-mode scimax-src-keymap-mode
;;   "Minor mode to add mode keymaps to src-blocks."
;;   :init-value nil
;;   (if scimax-src-keymap-mode
;;       (progn
;;         (add-hook 'org-font-lock-hook #'scimax-add-keymap-to-src-blocks t)
;;         (add-to-list 'font-lock-extra-managed-props 'local-map)
;;         (add-to-list 'font-lock-extra-managed-props 'cursor-sensor-functions)
;;         (advice-add 'lispy--eval :around 'scimax-spoof-mode)
;;         (cursor-sensor-mode +1))
;;     (remove-hook 'org-font-lock-hook #'scimax-add-keymap-to-src-blocks)
;;     (advice-remove 'lispy--eval 'scimax-spoof-mode)
;;     (cursor-sensor-mode -1))
;;   (font-lock-fontify-buffer))

;; (setq scimax-src-block-keymaps
;;       `(("r" . ,(let ((map (make-composed-keymap
;;                                  `(ess-r-mode-map)
;;                                  org-mode-map)))))))
;;         ;; ("emacs-lisp" . ,(let ((map (make-composed-keymap `(,lispy-mode-map ,emacs-lisp-mode-map ,outline-minor-mode-map) org-mode-map))) (define-key map (kbd "C-c C-c") 'org-ctrl-c-ctrl-c) map))))

;; (provide 'scimax)
