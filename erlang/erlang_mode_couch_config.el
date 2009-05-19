(provide 'erlang_mode_couch_config)

(add-to-list 'load-path "/opt/local/lib/erlang/lib/tools-2.6.4/emacs")
(require 'erlang-start)
(setq erlang-indent-level 4)
(add-to-list 'exec-path "/opt/local/lib/erlang/bin")
(setq erlang-root-dir "/opt/local/lib/erlang")

(setq erlang-skel-mail-address "brad@cloudant.com")

;; erl params for couchdb
(add-hook 'erlang-mode-hook 'my-erlang-mode-hook)
(defun my-erlang-mode-hook ()
  ;; prevent annoying hang-on-compile
  (defvar inferior-erlang-prompt-timeout t)
  ;; when starting an Erlang shell in Emacs, default in the node name
  (setq inferior-erlang-machine-options
        '("-sname" "couchdb1"
          "-smp" "auto" "errlog_type" "error" "+K" "true"
          "+P" "250000"
          "-D" "TEST=true"
          "-pa" "/Users/brad/dev/erlang/dbcore/src/couchdb"
          "-pa" "/Users/brad/dev/erlang/dbcore/src/mochiweb"
          "-pa" "/Users/brad/dev/erlang/dbcore/src/ibrowse"
          "-pa" "/Users/brad/dev/erlang/dbcore/src/cloudant"
          "-pa" "/Users/brad/dev/erlang/dbcore/src/dynomite"
          ;"-env" "ERL_LIBS" "/Users/brad/dev/erlang/dbcore/src"
          "-couch_ini"
          "/Users/brad/dev/erlang/dbcore/etc/couchdb/default_dev.ini"
          "/Users/brad/dev/erlang/dbcore/etc/couchdb/local_dev.ini"
          "/Users/brad/dev/erlang/dbcore/etc/couchdb/cluster.ini"
          "-pidfile" "/Users/brad/dev/erlang/dbcore/tmp/run/couchdb/couchdb.pid"
          "-ping" "http://localhost:5984/_cluster" ;; attach to cluster
          "-setcookie" "doubledoozie" ;; clustering
          ;;"-s" "couch_app" ;; this would start couch automatically
          ))

  ;; tell distel to default to that node
  (setq erl-nodename-cache
	(make-symbol
	 (concat
	  "couchdb1@"
	  ;; MAC OS X uses "name.local" instead of "name," this should work
	  ;; pretty much anywhere w/o having to much with NetInfo
	  (car (split-string (shell-command-to-string "hostname"))))))

  (define-key erlang-mode-map [f13]
    (lambda () (interactive)
      (progn
	(my-erlang-compile)))))
