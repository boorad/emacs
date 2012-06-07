(defun build-include (i)
  (let
      (buffer-dir (file-name-directory (buffer-file-name)))
    (format ", {i, \"%s\"}" (concat buffer-dir i))))

(defun my-erlang-compile ()
  "Compile the file in the current buffer."

  (interactive)
  (save-some-buffers)
  (or (inferior-erlang-running-p)
      (save-excursion
	(inferior-erlang)))
  (or (inferior-erlang-running-p)
      (error "Error starting inferior Erlang shell"))
  (let* (
	 (buffer-dir (file-name-directory (buffer-file-name)))
	 (ebin (concat buffer-dir "../ebin/"))
	 (ebindir (if (file-readable-p ebin) ebin buffer-dir))
	 (incl (concat
                "{i, \"../include\"}"
                (mapconcat 'build-include erlang-include-list "")))
;	 (incldir (if (file-readable-p incl) incl buffer-dir))
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
		       (format
                        (concat "c(\"%s\", "
                                "[{outdir, \"%s\"}, %s, "
                                "debug_info, export_all, "
                                "{d,'TEST'}, {d,'PROF'}]).")
                        noext ebindir incl)
		     (format
                      (concat "c(\"%s\", "
                              "[{outdir, \"%s\"}, %s, "
                              "{d,'TEST'},  {d,'PROF'}]).")
                      noext ebindir incl))
		 (format
		  (concat
		   "f(%s), {ok, %s} = file:get_cwd(), "
		   "file:set_cwd(\"%s\"), "
		   (if current-prefix-arg
		       (concat "%s = c(\"%s\", [debug_info, export_all, "
                               "{d,'TEST'}]), "
                               "file:set_cwd(%s), f(%s), %s."
                               "%s = c(\"%s\"), file:set_cwd(%s), f(%s), %s.")))
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


(provide 'my_erlang_compile)

(setq erlang-compile-function 'my-erlang-compile)

(add-hook 'erlang-mode-hook 'my-erlang-compile)

(run-mode-hooks)
