(provide 'dynomite_config)

(setq erlang-indent-level 2)

(setq erlang-skel-mail-address "brad@cloudant.com")

(add-to-list 'load-path "my_erlang_compile")
(require 'my_erlang_compile)

;; erl params for dynomite
(add-hook 'erlang-mode-hook 'my-erlang-mode-hook)
(defun my-erlang-mode-hook ()
  ;; prevent annoying hang-on-compile
  (defvar inferior-erlang-prompt-timeout t)
  ;; when starting an Erlang shell in Emacs, default in the node name
  (setq inferior-erlang-machine-options
        '("-sname" "dynomite"
          "-boot" "start_sasl"
          "+K" "true"
          "+A" "30"
          "+P" "250000"
          "-smp" "enable"
          "-pa" "/Users/brad/dev/erlang/dynomite/ebin"
          "-pa" "/Users/brad/dev/erlang/dynomite/deps/mochiweb/ebin"
          "-pa" "/Users/brad/dev/erlang/dynomite/deps/rfc4627/ebin"
          "-pa" "/Users/brad/dev/erlang/dynomite/deps/thrift/ebin"
          "-priv_dir" "/Users/brad/dev/erlang/dynomite/etest/log"
;          "-config" "test"
          "-dynomite" "config" "\"/Users/brad/dev/erlang/dynomite/config.json\""
          "-setcookie" "doubledoozie"
          ))

  ;; tell distel to default to that node
  (setq erl-nodename-cache
	(make-symbol
	 (concat
	  "dynomite@"
	  ;; MAC OS X uses "name.local" instead of "name," this should work
	  ;; pretty much anywhere w/o having to much with NetInfo
	  (car (split-string (shell-command-to-string "hostname")))))))
