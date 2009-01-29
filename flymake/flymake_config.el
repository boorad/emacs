(provide 'flymake_config)

(require 'flymake)

(defun flymake-erlang-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
		     'flymake-create-temp-inplace))
	 (local-file (file-relative-name
		      temp-file
		      (file-name-directory buffer-file-name))))
    (list "/Users/brad/dev/erlang/kevsmith/emacs/flymake/bin/eflymake" (list local-file))))

(add-to-list 'flymake-allowed-file-name-masks
	     '("\\.erl\\'" flymake-erlang-init))

(add-hook 'find-file-hook 'flymake-find-file-hook)
