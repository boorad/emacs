(provide 'couch_config)

(setq erlang-indent-level 4)
(setq erlang-tab-always-indent t)

(setq erlang-skel-mail-address "brad@cloudant.com")

;; erl params for couchdb
(add-hook 'erlang-mode-hook 'my-erlang-mode-hook)
(defun my-erlang-mode-hook ()
  ;; load flymake
  (flymake-mode)
  ;; prevent annoying hang-on-compile
  (defvar inferior-erlang-prompt-timeout t)
  ;; when starting an Erlang shell in Emacs, default in the node name
  (setq inferior-erlang-machine-options
        '("-name" "node1@node1.boorad.local"
          "-smp" "auto" "errlog_type" "error" "+K" "true"
          ;"+P" "250000"
          "-D" "TEST"
          "-D" "PROF"
          "-pa" "/Users/brad/dev/erlang/dbcore/src/couchdb"
          "-pa" "/Users/brad/dev/erlang/dbcore/src/mochiweb"
          "-pa" "/Users/brad/dev/erlang/dbcore/src/erlang-oauth"
          "-pa" "/Users/brad/dev/erlang/dbcore/src/ibrowse"
          "-pa" "/Users/brad/dev/erlang/dbcore/src/etap"
          "-pa" "/Users/brad/dev/erlang/dbcore/src/showroom/ebin"
          ;"-pa" "/Users/brad/dev/erlang/dbcore/src/cloudant" ; before 0.10.x
          "-pa" "/Users/brad/dev/erlang/dbcore/src/dynomite/ebin"
          "-pa" "/Users/brad/dev/erlang/bcrypt/lib/bcrypt/ebin"
          ;"-env" "ERL_LIBS" "/Users/brad/dev/erlang/dbcore/src"
          "-couch_ini"
          "/Users/brad/dev/erlang/dbcore/etc/couchdb/default_dev.ini"
          "/Users/brad/dev/erlang/dbcore/etc/couchdb/local_dev.ini"
          "/Users/brad/dev/erlang/dbcore/etc/couchdb/cluster.ini"
          "-pidfile" "/Users/brad/dev/erlang/dbcore/tmp/run/couchdb/couchdb.pid"
          "-setcookie" "doubledoozie" ;; clustering
          ;;"-s" "showroom" ;; this would start couch/showroom automatically
          ))

  ;; tell distel to default to that node
  (setq erl-nodename-cache
	(make-symbol
;	 (concat
	  "node1@node1.boorad.local"
	  ;; MAC OS X uses "name.local" instead of "name," this should work
	  ;; pretty much anywhere w/o having to much with NetInfo
;	  (car (split-string (shell-command-to-string "hostname")))))))
          )))
