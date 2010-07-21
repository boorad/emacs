(provide 'ditz_config)

(setq erlang-indent-level 4)
(setq erlang-tab-always-indent t)

(setq erlang-skel-mail-address "brad@cloudant.com")

;; erl params for couchdb
(add-hook 'erlang-mode-hook 'my-erlang-mode-hook)
(defun my-erlang-mode-hook ()
  ;; load flymake
  (flymake-mode)
  ;; prevent annoying hang-on-compile
  ;(defvar inferior-erlang-prompt-timeout t)
  ;; when starting an Erlang shell in Emacs, default in the node name
  (setq inferior-erlang-machine-options
        '("-name" "ditz@boorad.local"
          "-smp" "auto" "errlog_type" "error" "+K" "true"
          ;"+P" "250000"
          "-pa" "/Users/brad/dev/erlang/ditz/apps/ditz/ebin"
          "-pa" "/Users/brad/dev/erlang/ditz/apps/ibrowse/ebin"
          "-pa" "/Users/brad/dev/erlang/ditz/apps/tasks/ebin"
          "-setcookie" "ditz" ;; clustering
          ))

  ;; tell distel to default to that node
  (setq erl-nodename-cache
	(make-symbol
;	 (concat
	  "ditz@boorad.local"
	  ;; MAC OS X uses "name.local" instead of "name," this should work
	  ;; pretty much anywhere w/o having to much with NetInfo
;	  (car (split-string (shell-command-to-string "hostname")))))))
          )))
