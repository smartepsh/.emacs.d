(use-package page-break-lines
  :defer t)

(use-package dashboard
   :init
  (setq dashboard-banner-logo-title (format "Emacs startup in %.3fseconds" (float-time (time-subtract (current-time) emacs-start-time))))
  ;; (setq dashboard-startup-banner "~/.emacs.d/statics/xuenv.jpeg")
  (turn-on-page-break-lines-mode)
  :config
  (dashboard-setup-startup-hook))

(provide 'init-dashboard)
