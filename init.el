(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'after-init-hook #'(lambda ()
                               (setq gc-cons-threshold 4000000)))

(add-to-list 'load-path "~/.emacs.d/configs/")

(setq private/cache-directory "~/.emacs.d/.cache/")

(setq private/system-is-mac (eq system-type 'darwin))

;; emacs setting
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq create-lockfiles nil)

(require 'init-package)
(require 'init-server)
(require 'init-evil)
(require 'init-chinese)
(require 'init-ui)
(require 'init-env)
(require 'init-dashboard)
(require 'init-elixir)
(require 'init-ivy)
(require 'init-magit)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (alchemist ob-elixir elixir-mode dashboard page-break-lines evil use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
