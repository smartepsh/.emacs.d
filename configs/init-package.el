(unless (or (version= "28" emacs-version) package--initialized)
  (package-initialize))

(setq package-native-compile t
      use-package-expand-minimally t
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
(unless (package-installed-p 'quelpa)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
    (eval-buffer)
    (quelpa-self-upgrade)))

;; install quelpa-use-package
(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://github.com/quelpa/quelpa-use-package.git"))

(require 'quelpa-use-package)

;; (setq use-package-ensure-function 'quelpa)
(quelpa-use-package-activate-advice)

;; (use-package auto-package-update
;;   :defer t
;;   :config
;;   (setq auto-package-update-delete-old-versions nil))

;; replaced by package-utils
;; (use-package use-package-ensure-system-package)

(use-package benchmark-init
  :config
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

(use-package package-utils)

(provide 'init-package)
