(setq private/rime-directory (concat private/config-directory "rime/"))
(setq private/offical-rime-directory "/Library/Input Methods/Squirrel.app/Contents/SharedSupport")

(use-package cnfonts
  :defer t
  :init
  (add-hook 'after-init-hook #'cnfonts-enable))

(use-package liberime
  :load-path private/rime-directory
  :config
  (liberime-start private/offical-rime-directory (expand-file-name private/rime-directory))
  (liberime-select-schema "luna_pinyin_simp"))

(use-package pyim
  :after liberime
  :init
  (setq pyim-page-tooltip 'posframe)
  (setq pyim-page-length 9)
  (setq default-input-method "pyim")
  (setq pyim-default-scheme 'rime-quanpin))

(use-package posframe
  :defer t)

(provide 'init-chinese)
