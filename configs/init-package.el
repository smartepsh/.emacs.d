(unless (or (version= "27" emacs-version) package--initialized)
  (package-initialize))

(setq use-package-expand-minimally t
      use-package-always-ensure t
      package-enable-at-startup nil
      package-archives '(("melpa" . "https://melpa.org/packages/")
                        ("org"   . "https://orgmode.org/elpa/")
                        ("gnu"   . "https://elpa.gnu.org/packages/")))

      ;; package-archives '(("melpa-cn" . "https://elpa.emacs-china.org/melpa/")
      ;;                   ("org-cn"   . "https://elpa.emacs-china.org/org/")
      ;;                   ("gnu-cn"   . "https://elpa.emacs-china.org/gnu/"))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; disable update during quelpa initialized
(setq quelpa-update-melpa-p nil
      quelpa-checkout-melpa-p t)

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

;; (setq use-package-ensure-function 'quelpa)
(quelpa-use-package-activate-advice)

(use-package auto-package-update
  :defer t
  :config
  (setq auto-package-update-delete-old-versions nil))

(use-package use-package-ensure-system-package)

(provide 'init-package)
