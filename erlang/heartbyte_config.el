(provide 'heartbyte_config)

(setq erlang-indent-level 4)
(setq erlang-tab-always-indent t)

(setq erlang-skel-mail-address "brad@sankatygroup.com")

;; erl params for dynomite
(add-hook 'erlang-mode-hook 'my-erlang-mode-hook)
(defun my-erlang-mode-hook ()
  ;; load flymake
  (flymake-mode)
  ;; prevent annoying hang-on-compile
  ;(defvar inferior-erlang-prompt-timeout t)
  ;; when starting an Erlang shell in Emacs, default in the node name
  (setq inferior-erlang-machine-options
        '("-name" "hb@boorad.local"
          "-smp" "auto"
          "errlog_type" "error"
          "+K" "true"
          "-pa" "/Users/brad/dev/heartbyte/tsungsqs/ebin"
          "-pa" "/Users/brad/dev/heartbyte/collecterl/apps"
          "-pa" "/Users/brad/dev/heartbyte/collecterl/deps"
          "-pa" "/Users/brad/dev/heartbyte/hbclient/apps"
          "-pa" "/Users/brad/dev/heartbyte/hbclient/deps"
          "-setcookie" "doubledoozie"
          ))

  ;; tell distel to default to that node
  (setq erl-nodename-cache
	(make-symbol
;	 (concat
	  "hb@boorad.local"
	  ;; MAC OS X uses "name.local" instead of "name," this should work
	  ;; pretty much anywhere w/o having to much with NetInfo
;	  (car (split-string (shell-command-to-string "hostname")))))))
          )))
