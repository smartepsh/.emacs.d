(use-package page-break-lines)

(use-package dashboard
   :init
  (setq dashboard-banner-logo-title "Hi! Kenton Wang!")
  ;; (setq dashboard-startup-banner "~/.emacs.d/statics/xuenv.jpeg")
  (turn-on-page-break-lines-mode)
  :config
  (dashboard-setup-startup-hook))

(provide 'init-dashboard)
