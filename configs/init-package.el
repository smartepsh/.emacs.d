(package-initialize)

(setq package-enable-at-startup nil)
(setq package-archives '(("melpa-cn" . "http://elpa.zilongshanren.com/melpa/")
                        ("org-cn"   . "http://elpa.zilongshanren.com/org/")
                        ("gnu-cn"   . "http://elpa.zilongshanren.com/gnu/")))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(setq use-package-always-ensure t)

(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions nil))

(use-package quelpa-use-package
  :after use-package)
  

(provide 'init-package)
