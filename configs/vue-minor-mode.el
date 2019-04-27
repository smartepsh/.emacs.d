(require 'json)

(define-minor-mode vue-minor-mode
  "Kenton Wang's vue minor modes"
  :keymap (make-sparse-keymap))

(defun enable-vue-minor-mode ()
  (if (vue-project-p)
      (vue-minor-mode)))

(defun vue-project-p ()
  "Determine the project is vue project"
  (interactive)
  (if (projectile-project-p)
      (if (file-exists-p (concat (projectile-project-root) "package.json"))
          (let* ((json-object-type 'hash-table)
                 (json-array-type 'list)
                 (json-key-type 'string)
                 (json (json-read-file (concat (projectile-project-root) "package.json"))))
            (if (gethash "vue" (gethash "dependencies" json))
                t)))))

(local-leader
  :keymaps 'vue-minor-mode-map
  "t" '+vue/find-template-file
  "q" '+vue/find-style-file
  "w" '+vue/find-script-file)

(defun +vue/find-template-file ()
    (interactive)
  (+vue/find-component-file  "src/component" ".vue"))

(defun +vue/find-style-file ()
    (interactive)
  (+vue/find-component-file  "src/component" ".css"))

(defun +vue/find-script-file ()
    (interactive)
  (+vue/find-component-file "src/component" ".js"))

(defun +vue/find-component-file (component-path target-type)
  (let ((file-name (buffer-file-name (current-buffer))))
    (if (string-match-p component-path file-name)
          (find-file (concat (file-name-sans-extension file-name) target-type))
      (message "You are not in the component folder !"))))

(provide 'vue-minor-mode)
