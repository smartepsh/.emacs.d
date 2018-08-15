(use-package restart-emacs
  :config
  (global-set-key (kbd "H-r") 'restart-emacs)
  )

  (common-leader
    "SPC" 'execute-extended-command)
    ;;"ff" 'find-file)

(provide 'init-emacs)
