(use-package ispell)

(use-package flyspell
  :defer t)

(use-package flyspell-correct-ivy
  :commands
  (flyspell-correct-ivy)
  :init
  (setq flyspell-correct-interface #'flyspell-correct-ivy))

(provide 'init-spell-checking)
