(provide 'erlang_mode_couch_config)

(add-to-list 'load-path "/opt/local/lib/erlang/lib/tools-2.6.3/emacs")
(require 'erlang-start)
(setq erlang-indent-level 4)
(add-to-list 'exec-path "/opt/local/lib/erlang/bin")
(setq erlang-root-dir "/opt/local/lib/erlang")

(setq erlang-skel-mail-address "brad@sankatygroup.com")

;; erl params for couchdb
(add-hook 'erlang-mode-hook 'my-erlang-mode-hook)
(defun my-erlang-mode-hook ()
  ;; prevent annoying hang-on-compile
  (defvar inferior-erlang-prompt-timeout t)
  ;; when starting an Erlang shell in Emacs, default in the node name
  (setq inferior-erlang-machine-options
        '("-sname" "couchdev"
          "-smp" "auto" "errlog_type" "error" "+K" "true"
          "-pa" "/Users/brad/dev/boorad/dbcore/src/couchdb"
          "-pa" "/Users/brad/dev/boorad/dbcore/src/mochiweb"
          "-pa" "/Users/brad/dev/boorad/dbcore/src/ibrowse"
          "-dini" "/Users/brad/dev/boorad/dbcore/etc/couchdb/default_dev.ini"
          "-lini" "/Users/brad/dev/boorad/dbcore/etc/couchdb/local_dev.ini"
          "-pidfile" "/Users/brad/dev/boorad/dbcore/tmp/run/couchdb/couchdb.pid"
          "-start" "couch_app"))

  ;; tell distel to default to that node
  (setq erl-nodename-cache
	(make-symbol
	 (concat
	  "couchdev@"
	  ;; MAC OS X uses "name.local" instead of "name," this should work
	  ;; pretty much anywhere w/o having to much with NetInfo
	  (car (split-string (shell-command-to-string "hostname"))))))

  (define-key erlang-mode-map [f13]
    (lambda () (interactive)
      (progn
	(my-erlang-compile)))))
