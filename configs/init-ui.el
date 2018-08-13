(use-package doom-themes
  :init
  (setq doom-themes-enable-bold t
  doom-themes-enable-italic t)
  (load-theme 'doom-one t))

(scroll-bar-mode -1)
(tool-bar-mode -1)

(use-package powerline
  :init
  (setq powerline-image-apple-rgb t
	powerline-default-separator 'box)
  (powerline-vim-theme))

(use-package airline-themes
  :after powerline
  :config
  (load-theme 'airline-doom-one))


;; (defface egoge-display-time
;;    '((((type x w32 mac))
;;       ;; #060525 is the background colour of my default face.
;;       (:foreground "#060525" :inherit bold))
;;      (((type tty))
;;       (:foreground "blue")))
;;    "Face used to display the time in the mode line.")

;; (setq display-time-string-forms
;;        '((propertize (concat " " 24-hours ":" minutes " ")
;;  		    'face 'egoge-display-time)))

(display-time-mode t)

(display-battery-mode 1)

(use-package linum-relative
  :defer t
  :config
  (setq linum-relative-backend 'display-line-numbers-mode))

(use-package diminish
  :ensure t
  :demand t
  :diminish abbrev-mode)

(provide 'init-ui)
