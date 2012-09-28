(provide 'reflex_config)

(setq erlang-indent-level 4)
(setq erlang-tab-always-indent t)

(setq erlang-skel-mail-address "brad@sankatygroup.com")

;;(setq erlang-include-list ())
(setq erlang-include-list
      (list
       "/Users/brad/dev/reflex/apps"
       "/Users/brad/dev/reflex/deps"
       "/Users/brad/dev/reflex/apps/vep/include"
       "/Users/brad/dev/reflex/apps/sesh/include"
       "/Users/brad/dev/reflex/deps/nerlo/include"
       ))

(defvar erlang-compile-extra-opts
  '(bin_opt_info debug_info (i . "../include") (i . "../deps") (i . "../../") (i . "../../../deps")))

;; erl params
(add-hook 'erlang-mode-hook 'my-erlang-mode-hook)
(defun my-erlang-mode-hook ()
  ;; load flymake
  (flymake-mode)
  ;; prevent annoying hang-on-compile
  ;(defvar inferior-erlang-prompt-timeout t)
  ;; when starting an Erlang shell in Emacs, default in the node name

  ;;@boorad-2.local"
  (setq inferior-erlang-machine-options
        '("-sname" "reflex"
          "-smp" "auto"
          "errlog_type" "error"
          "+K" "true"
          "-setcookie" "123456"
          ))

  ;; tell distel to default to that node
  (setq erl-nodename-cache 'reflex)
;; 	(make-symbol
;; ;	 (concat
;; 	  "reflex@boorad.local"
;; 	  ;; MAC OS X uses "name.local" instead of "name," this should work
;; 	  ;; pretty much anywhere w/o having to much with NetInfo
;; ;	  (car (split-string (shell-command-to-string "hostname")))))))
;;           ))

  (setenv "ERL_LIBS"
          (concat
           "/Users/brad/dev/reflex/apps"
           ":"
           "/Users/brad/dev/reflex/deps"
           )))
