(use-package elixir-mode
             :defer t)

(use-package alchemist
             :defer t
             :init
             (add-hook 'elixir-mode-hook 'alchemist-mode))

(provide 'init-elixir)
