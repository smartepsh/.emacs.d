(use-package flyspell
  :ensure-system-package hunspell
  :hook (text-mode . flyspell-mode)
  :hook (prog-mode . flyspell-prog-mode)
  :init
  (setenv "LANG" "en_US")
  (setq flyspell-issue-welcome-flag nil)
  :config
    (setq ispell-program-name (executable-find "hunspell")
        ispell-dictionary "en_US"
        ispell-local-dictionary-alist '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8))))

(use-package flyspell-correct-ivy
  :after flyspell-correct)

(use-package flyspell-correct
  :commands (flyspell-correct-wrapper)
  :init
  (setq flyspell-correct-interface 'flyspell-correct-ivy)
  :general
  (general-define-key
   :keymaps 'flyspell-mode-map
   "C-;" 'flyspell-correct-wrapper
   "C-," nil))

(provide 'init-spell-checking)
