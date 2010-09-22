(provide 'ericssontv_config)

(setq erlang-indent-level 4)
(setq erlang-tab-always-indent t)

(setq erlang-skel-mail-address "brad@sankatygroup.com")

;; erl params for couchdb
(add-hook 'erlang-mode-hook 'my-erlang-mode-hook)
(defun my-erlang-mode-hook ()
  ;; load flymake
  (flymake-mode)
  ;; prevent annoying hang-on-compile
  ;(defvar inferior-erlang-prompt-timeout t)
  ;; when starting an Erlang shell in Emacs, default in the node name
  (setq inferior-erlang-machine-options
        '(
          ;; "-name" "node1@node1.boorad.local"
          "-smp" "auto"
          "errlog_type" "error"
          "+K" "true"
          "-pa" "/Users/brad/dev/tv/qam_rm/ebin"
          "-pa" "/Users/brad/dev/tv/qam_rm/deps/effigy/ebin"
          "-pa" "/Users/brad/dev/tv/qam_rm/deps/amqp_client/ebin"
          "-pa" "/Users/brad/dev/tv/qam_rm/deps/gen_bunny/ebin"
          "-pa" "/Users/brad/dev/tv/monaco_erlang_utils/ebin"
          "-setcookie" "doubledoozie" ;; clustering
          ))

;  ;; tell distel to default to that node
;  (setq erl-nodename-cache
;	(make-symbol
;;	 (concat
;	  "node1@node1.boorad.local"
;	  ;; MAC OS X uses "name.local" instead of "name," this should work
;	  ;; pretty much anywhere w/o having to much with NetInfo
;;	  (car (split-string (shell-command-to-string "hostname")))))))
;          )))
)
