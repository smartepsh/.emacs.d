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
  (setq pyim-title "Chinese")
  (setq pyim-page-tooltip 'posframe)
  (setq pyim-page-length 9)
  (setq default-input-method "pyim")
  (setq pyim-default-scheme 'rime)
  ;; 全角半角切换列表: 半角/全校/自动切换
  (setq pyim-punctuation-translate-p '(no yes))
  :config
  (global-set-key (kbd "M-f") 'pyim-forward-word)
  (global-set-key (kbd "M-b") 'pyim-backward-word)
  ;; 全角半角切换
  (global-set-key (kbd "C-`") 'pyim-punctuation-toggle)
  :general
  (general-define-key
   :keymaps '(pyim-mode-map)
   "]" 'pyim-page-next-page
   "[" 'pyim-page-previous-page))

(use-package posframe
  :defer t)

(provide 'init-chinese)
