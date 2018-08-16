(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'after-init-hook #'(lambda ()
                               (setq gc-cons-threshold 2010241024)))

(add-to-list 'load-path "~/.emacs.d/configs/")

(setq private/cache-directory "~/.emacs.d/.cache/")

(setq private/system-is-mac (eq system-type 'darwin))

;; emacs setting
(setq auto-save-default nil
      make-backup-files nil
      create-lockfiles nil
      ;; key setting for mac
      ns-command-modifier 'super
      ns-option-modifer 'meta
      ns-right-option-modifier 'hyper
      ns-right-command-modifier 'hyper)

(let ((proxy-file "~/.emacs.d/proxy.el"))
  (if (file-exists-p proxy-file)
      (load proxy-file)
    (message "no proxy setting!")))

(require 'init-package)
(require 'init-basic-settings)
(require 'init-evil)
(require 'init-ui)
(require 'init-server)
(require 'init-emacs)
(require 'init-chinese)
(require 'init-env)
;; (require 'init-dashboard)
(require 'init-elixir)
(require 'init-ivy)
(require 'init-magit)
(require 'init-projectile)
(require 'init-company)
(require 'init-spell-checking)
(require 'init-syntax-checking)
(require 'init-mac)
(require 'init-org)
(require 'init-file-nav)
(require 'init-jumping)

;;(custom-set-variables
;; ;; custom-set-variables was added by Custom.
;; ;; If you edit it by hand, you could mess it up, so be careful.
;; ;; Your init file should contain only one such instance.
;; ;; If there is more than one, they won't work right.
;; '(column-number-mode t)
;; '(custom-safe-themes
;;   (quote
;;    ("a94f1a015878c5f00afab321e4fef124b2fc3b823c8ddd89d360d710fc2bddfc" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
;; '(line-number-mode nil)
;; '(package-selected-packages
;;   (quote
;;    (vimish-fold evil-surround evil-matchit counsel-projectile quelpa diminish linum-relative alchemist ob-elixir elixir-mode dashboard page-break-lines evil use-package)))
;; '(powerline-height 15)
;; '(size-indication-mode t))
;;(custom-set-faces
;; ;; custom-set-faces was added by Custom.
;; ;; If you edit it by hand, you could mess it up, so be careful.
;; ;; Your init file should contain only one such instance.
;; ;; If there is more than one, they won't work right.
;; '(vimish-fold-fringe ((t (:foreground "SteelBlue2")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (avy neotree winum osx-trash flycheck flyspell-correct-ivy smartparens company-statistics counsel-projectile projectile evil-magit magit counsel swiper ivy alchemist ob-elixir elixir-mode dashboard page-break-lines exec-path-from-shell cnfonts restart-emacs linum-relative spaceline nyan-mode evil-anzu eyebrowse doom-themes vimish-fold evil-surround evil-matchit evil-escape evil which-key general popwin auto-package-update quelpa-use-package use-package bind-key quelpa))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(vimish-fold-fringe ((t (:foreground "SteelBlue2")))))
