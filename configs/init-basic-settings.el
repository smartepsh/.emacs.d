(setq ring-bell-function 'ignore
      scroll-margin 0
      scroll-conservatively 1001
      scroll-preserve-screen-position t)

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(fset #'yes-or-no-p #'y-or-n-p)

(setq-default ident-tabs-mode nil)
(setq tab-width 2)

;; emacs setting
(setq auto-save-default nil
      make-backup-files nil
      create-lockfiles nil
      x-select-enable-clipboard nil
      ;; key setting for mac
      ns-command-modifier 'super
      ns-option-modifer 'meta
      ns-right-option-modifier 'hyper
      ns-right-command-modifier 'hyper
      inhibit-startup-screen t)

(setq custom-file "~/.emacs.d/custom.el")

(if (file-exists-p custom-file)
    (load custom-file)
  (message "no custom setting file!"))

(setq sql-connection-alist
      '((os_service_staging (sql-product 'postgres)
			    (sql-default-directory "/ssh:deploy@101.37.79.214:")
			    (sql-server "10.29.113.245")
			    (sql-user "deploy")
			    (sql-database "os_service_staging")
			    (sql-port 5432))
	(localhost (sql-product 'postgres)
		   (sql-default-directory "/Users/smartepsh")
		   (sql-server "127.0.0.1")
		   (sql-user "postgres")
		   (sql-database "postgres")
		   (sql-port 5432))))

;; shell setting
;; .zshenv
;;
;; test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"
;; [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
;; export NVM_DIR="$HOME/.nvm"
;; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
;; [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
;; eval "$(rbenv init -)"

(provide 'init-basic-settings)
