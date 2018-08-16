(use-package ivy
  :init
  (ivy-mode 1)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (global-set-key "\C-s" 'swiper)
  :general
  (common-leader
    "/" 'counsel-ag))

(use-package swiper
  :defer t
  :after ivy)

(use-package counsel
  :defer t
  :after ivy)

(provide 'init-ivy)
