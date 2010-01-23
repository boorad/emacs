(defun my-python-compile ()
  "Use compile to run python programs"
  (interactive)
  (compile (concat "python " (buffer-name))))
(setq compilation-scroll-output t)

(defun my-python-mode-hook ()
  (local-unset-key "\C-c\C-k")
  (global-unset-key "\C-c\C-k")
  (local-set-key "\C-c\C-k" 'my-python-compile))

(defvar python-compile-function 'my-python-compile
  "Command to execute to compile current buffer.")

(provide 'my-python-compile)

(setq python-compile-function 'my-python-compile)

(add-hook 'python-mode-hook 'my-python-compile)
(add-hook 'python-mode-hook 'my-python-mode-hook)

(run-mode-hooks)
