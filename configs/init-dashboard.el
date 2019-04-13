;; (use-package page-break-lines
;;   :defer t)

;; (use-package dashboard
;;    :init
;;   (setq dashboard-banner-logo-title (format "Emacs startup in %.3f seconds" (float-time (time-subtract (current-time) emacs-start-time))))
;;   ;; (setq dashboard-startup-banner "~/.emacs.d/statics/xuenv.jpeg")
;;   (turn-on-page-break-lines-mode)
;;   :config
;;   (add-hook 'after-init-hook '(lambda ()
;;   				(dashboard-insert-startupify-lists)))
;;   (add-hook 'window-setup-hook '(lambda ()
;; 				  (switch-to-buffer "*dashboard*")
;; 				  (goto-char (point-min))
;; 				  (redisplay))))

(add-hook 'window-setup-hook '(lambda ()
				(message (format "Emacs startup in %.3f seconds" (float-time (time-subtract (current-time) emacs-start-time))))))

(setq initial-scratch-message nil)
;; (toggle-frame-maximized)
(set-frame-position (selected-frame) 1300 0)
(set-frame-width (selected-frame) 110)
(set-frame-height (selected-frame) 68)

(provide 'init-dashboard)
