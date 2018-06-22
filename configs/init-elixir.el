(use-package elixir-mode
             :defer t)

(use-package ob-elixir
             :after org
             :init
             (add-to-list 'org-babel-load-languages '(elixir . t)))

(use-package alchemist
             :defer t
             :init
             (add-hook 'elixir-mode-hook 'alchemist-mode))

(provide 'init-elixir)
