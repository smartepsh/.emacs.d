(setq private/rime-directory (concat private/config-directory "rime/"))
(setq private/offical-rime-directory "/Library/Input Methods/Squirrel.app/Contents/SharedSupport")

(use-package cnfonts
  :defer t
  :init
  (add-hook 'after-init-hook #'cnfonts-enable)
  (setq cnfonts-use-face-font-rescale t))

(use-package rime
  :defer t
  :custom
  (default-input-method "rime")
  :init
  (setq rime-librime-root (concat private/rime-directory "dist/")
        rime-show-candidate 'posframe
        rime-posframe-style 'vertical
        rime-show-preedit 'inline
        rime-disable-predicates '(rime-predicate-hydra-p
                                  rime-predicate-evil-mode-p
                                  rime-predicate-prog-in-code-p
                                  rime-predicate-punctuation-after-ascii-p))
  :config
  (global-set-key (kbd "M-s-SPC") 'rime-inline-ascii))

(use-package posframe
  :defer t)

(provide 'init-chinese)
