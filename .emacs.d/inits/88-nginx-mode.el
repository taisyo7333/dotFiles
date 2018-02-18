;;; nginx-mode --- nginx mode:
;;; Commentary:

(require 'nginx-mode)

;;; Code:
(add-to-list 'auto-mode-alist '("nginx\\(.*\\).conf[^/]*$" . nginx-mode))

;;; hook:
(defun my-nginx-mode-hook ()
  "Hooks for Nginx mode."
  (setq nginx-indent-level 2)
  (setq indent-tabs-mode nil)
  (setq tab-width 2)
  (message "now set to: nginx-mode"))

(add-hook 'nginx-mode-hook 'my-nginx-mode-hook)
