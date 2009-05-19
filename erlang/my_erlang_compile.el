(defun my-erlang-compile (args)
  "Compile the file in the current buffer."

  (interactive "P")
;;  (save-current-buffer
;;    (inferior-erlang-compile))
  (save-some-buffers)
  (or (inferior-erlang-running-p)
      (save-excursion
	(inferior-erlang)))
  (or (inferior-erlang-running-p)
      (error "Error starting inferior Erlang shell"))
;;;  (let ((dir (file-name-directory (buffer-file-name)))
  (let* (
	 (buffer-dir (file-name-directory (buffer-file-name)))
	 (ebin (concat buffer-dir "../ebin/"))
	 (dir (if (file-readable-p ebin) ebin buffer-dir))
;;; (file (file-name-nondirectory (buffer-file-name)))
	(noext (substring (buffer-file-name) 0 -4))
	;; Hopefully, noone else will ever use these...
	(tmpvar "Tmp7236")
	(tmpvar2 "Tmp8742")
	end)
    (inferior-erlang-display-buffer)
    (inferior-erlang-wait-prompt)
    (setq end (inferior-erlang-send-command
	       (if erlang-compile-use-outdir
		   (if current-prefix-arg
		       (format "c(\"%s\", [{outdir, \"%s\"}, debug_info, export_all, {d,'TEST'}])." noext dir)
		     (format "c(\"%s\", [{outdir, \"%s\"},  {d,'TEST'}])." noext dir))
		 (format
		  (concat
		   "f(%s), {ok, %s} = file:get_cwd(), "
		   "file:set_cwd(\"%s\"), "
		   (if current-prefix-arg
		       "%s = c(\"%s\", [debug_info, export_all {d,'TEST'}]), file:set_cwd(%s), f(%s), %s."
		     "%s = c(\"%s\"), file:set_cwd(%s), f(%s), %s."))
		  tmpvar2 tmpvar
		  dir
		  tmpvar2 noext tmpvar tmpvar tmpvar2))
	       nil))
    (inferior-erlang-wait-prompt)
    (save-excursion
      (set-buffer inferior-erlang-buffer)
      (setq compilation-error-list nil)
      (set-marker compilation-parsing-end end))
    (setq compilation-last-buffer inferior-erlang-buffer)))


(defvar erlang-compile-function 'my-erlang-compile
  "Command to execute to compile current buffer.")

(provide 'my_erlang_compile)

(add-hook 'erlang-mode-hook 'my-erlang-compile)

(run-mode-hooks)
