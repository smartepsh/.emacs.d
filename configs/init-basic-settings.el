(setq ring-bell-function 'ignore
      scroll-margin 0
      scroll-conservatively 1001
      scroll-preserve-screen-position t)

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(fset #'yes-or-no-p #'y-or-n-p)

(setq-default ident-tabs-mode nil)
(setq tab-width 2)

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

(provide 'init-basic-settings)
