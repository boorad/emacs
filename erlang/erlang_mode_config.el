(provide 'erlang_mode_config)

(add-to-list 'load-path "/opt/local/lib/erlang/lib/tools-2.6.4/emacs")
(require 'erlang-start)
(setq erlang-indent-level 2)
(add-to-list 'exec-path "/opt/local/lib/erlang/bin")
(setq erlang-root-dir "/opt/local/lib/erlang")

(setq erlang-skel-mail-address "brad@sankatygroup.com")