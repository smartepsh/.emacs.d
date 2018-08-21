(setq emacs-start-time (current-time))
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'after-init-hook #'(lambda ()
                               (setq gc-cons-threshold 5121024)))

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
(require 'init-evil)
(require 'init-basic-settings)
(require 'init-ui)
(require 'init-emacs)
(require 'init-chinese)
(require 'init-env)
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
(require 'init-server)
(require 'init-dashboard)

;; shell setting
;; .zshenv
;;
;; test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"
;; [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
;; export NVM_DIR="$HOME/.nvm"
;; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
;; [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
;; eval "$(rbenv init -)"

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
)
