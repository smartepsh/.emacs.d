(package-initialize)

;; (unless (package-installed-p 'use-package)
;;   (package-refresh-contents)
;;   (package-install 'use-package))

;; disable update during quelpa initialized
(setq quelpa-update-melpa-p nil)
(setq quelpa-checkout-melpa-p nil)
;; install quelpa
(unless (require 'quelpa nil t)
  (with-temp-buffer
    (url-insert-file-contents "https://framagit.org/steckerhalter/quelpa/raw/master/bootstrap.el")
    (eval-buffer)))

;; (quelpa-self-upgrade)

;; install quelpa-use-package
(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://framagit.org/steckerhalter/quelpa-use-package.git"))
(require 'quelpa-use-package)

;; (require 'use-package)

;; (setq use-package-ensure-function 'quelpa)
(setq use-package-expand-minimally t
      use-package-always-ensure t
      package-enable-at-startup nil
      package-archives '(("melpa-cn" . "http://elpa.zilongshanren.com/melpa/")
                        ("org-cn"   . "http://elpa.zilongshanren.com/org/")
                        ("gnu-cn"   . "http://elpa.zilongshanren.com/gnu/")))

(quelpa-use-package-activate-advice)


(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions nil))

(provide 'init-package)
