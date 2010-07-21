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
  ;(defvar inferior-erlang-prompt-timeout t)
  ;; when starting an Erlang shell in Emacs, default in the node name
  (setq inferior-erlang-machine-options
        '("-name" "node1@node1.boorad.local"
          "-smp" "auto"
          "errlog_type" "error"
          "+K" "true"
          "-D" "TEST"
          "-D" "PROF"
          "-pa" "/Users/brad/dev/erlang/dbcore/apps/chttpd/ebin"
          "-pa" "/Users/brad/dev/erlang/dbcore/apps/couch/ebin"
          "-pa" "/Users/brad/dev/erlang/dbcore/apps/mochiweb/ebin"
          "-pa" "/Users/brad/dev/erlang/dbcore/apps/oauth/ebin"
          "-pa" "/Users/brad/dev/erlang/dbcore/apps/ibrowse/ebin"
          "-pa" "/Users/brad/dev/erlang/dbcore/apps/etap/ebin"
          "-pa" "/Users/brad/dev/erlang/dbcore/apps/mem3/ebin"
          "-pa" "/Users/brad/dev/erlang/dbcore/apps/rexi/ebin"
          "-pa" "/Users/brad/dev/erlang/dbcore/apps/fabric/ebin"
          "-pa" "/Users/brad/dev/erlang/bcrypt/lib/bcrypt/ebin"
          "-pa" "/Users/brad/dev/cloudant/scripts/devstart/ebin"
          "-pa" "/Users/brad/dev/erlang/dbcore/apps/showroom/ebin"
          "-couch_ini"
          "/Users/brad/dev/erlang/dbcore/rel/cloudant-core/etc/default1.ini"
          "-pidfile" "/srv/run/couchdb/couchdb1.pid"
          ;; "-eval" "\"crypto:start()\""
          ;; "-eval" "\"ssl:start()\""
          ;; "-eval" "\"application:start(inets)\""
          ;; "-eval" "\"application:start(oauth)\""
          ;; "-eval" "\"application:start(mochiweb)\""
          ;; "-eval" "\"application:start(sasl)\""
          ;; "-eval" "\"application:start(ibrowse)\""
          ;; ;"-eval" "\"showroom:start()\""
          "-setcookie" "doubledoozie" ;; clustering
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
