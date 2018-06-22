(add-to-list 'load-path "~/.emacs.d/configs/")

(setq private/cache-directory "~/.emacs.d/.cache/")

(require 'init-package)
(require 'init-evil)
(require 'init-dashboard)
(require 'init-elixir)

;;(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;;'(package-selected-packages '(use-package)))
;;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;;)
