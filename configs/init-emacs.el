(use-package restart-emacs
  :config
  (global-set-key (kbd "H-r") 'restart-emacs)
  )

  (my-leader-def
    "" nil
    "SPC" 'execute-extended-command
    "ff" 'find-file)

(provide 'init-emacs)
