(use-package flyspell
  :ensure-system-package hunspell
  :hook (text-mode . flyspell-mode)
  :hook (prog-mode . flyspell-prog-mode)
  :init
  (setq flyspell-issue-welcome-flag nil)
  :config
    (setq ispell-program-name (executable-find "hunspell")
	ispell-dictionary "en_US"
	ispell-local-dictionary-alist '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US,en_US-med") nil utf-8))))

(use-package flyspell-correct-ivy
  :after flyspell-correct)

(use-package flyspell-correct
  :commands (flyspell-correct-word-generic
	     flyspell-correct-previous-word-generic)
  :init
  (setq flyspell-correct-interface 'flyspell-correct-ivy)
  :general
  (general-define-key
   :keymaps 'flyspell-mode-map
   "C-;" 'flyspell-correct-previous-word-generic))

(provide 'init-spell-checking)
