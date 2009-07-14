(provide 'my_config)

;; color-theme
(add-to-list 'load-path "~/dev/emacs/color-theme") ;; Configuration for color-theme

;; Tweaking editing environment
(setq-default show-trailing-whitespace t)
;;(add-to-list 'default-frame-alist '(alpha . (100 70)))
(add-to-list 'default-frame-alist '(alpha . (100 100)))
(add-to-list 'load-path "~/dev/emacs/igrep") ;; igrep
(add-to-list 'load-path "~/dev/emacs/erlang") ;; Configuration for Erlang mode
(add-to-list 'load-path "~/dev/emacs/custom_keys") ;; Custom keys config
(add-to-list 'load-path "~/dev/emacs/flymake") ;; Flymake syntax checker
;;(add-to-list 'load-path "~/dev/emacs/git") ;; Git mode
(add-to-list 'load-path "~/dev/emacs/magit") ;; magit mode
(add-to-list 'load-path "~/dev/emacs/distel/elisp") ;; Distel package
(add-to-list 'load-path "~/dev/emacs/whitespace") ;; Whitespace package
(add-to-list 'load-path "~/dev/emacs/autosave") ;; Autosave config

;(require 'erlang_mode_config) ;; Loading Erlang mode (dubdub & general config)
(require 'erlang_mode_couch_config) ;; Loading Erlang mode (couchdb config)
;(require 'erlang_mode_dynomite_config) ;; Loading Erlang mode (dynomite config)

(require 'igrep) ;; igrep
(autoload 'igrep "igrep"
  "*Run `grep` PROGRAM to match REGEX in FILES..." t)
(autoload 'igrep-find "igrep"
  "*Run `grep` via `find`..." t)
(autoload 'igrep-visited-files "igrep"
  "*Run `grep` ... on all visited files." t)
(autoload 'dired-do-igrep "igrep"
  "*Run `grep` on the marked (or next prefix ARG) files." t)
(autoload 'dired-do-igrep-find "igrep"
  "*Run `grep` via `find` on the marked (or next prefix ARG) directories." t)
(autoload 'Buffer-menu-igrep "igrep"
  "*Run `grep` on the files visited in buffers marked with '>'." t)
(autoload 'igrep-insinuate "igrep"
  "Define `grep' aliases for the corresponding `igrep' commands." t)


(require 'custom_keys_config) ;; custom key bindings
(require 'flymake_config) ;; Loading flymake
;;(require 'git) ;; Loading git
(require 'magit) ;; Loading magit
(require 'distel) ;; Loading distel
(require 'whitespace_config) ;; Loading whitespace
(require 'autosave_config) ;; Configures autosaving

(distel-setup)

;; tab lovin'
(setq-default indent-tabs-mode nil) ; always replace tabs with spaces
(setq-default tab-width 8) ; set tab width to 4 for all buffers

;; refresh file
;; from http://www.stokebloke.com/wordpress/2008/04/17/emacs-refresh-f5-key/
(defun refresh-file ()
  (interactive)
  (revert-buffer t t t)
  )

(global-set-key [f5] 'revert-buffer)


;; ;; from Roberto Saccon
;; ;; http://www.rsaccon.com/2007/10/erlang-compilation-with-emacs.html
;; (defun my-erlang-compile ()
;;   (interactive)
;;   (save-some-buffers (not compilation-ask-about-save) nil)
;;   (save-excursion
;;     (let ((thisdir default-directory))
;;       (setq src-file-name buffer-file-name)
;;       (with-current-buffer (get-buffer-create "*erl-output*")
;; 	(setq default-directory thisdir)
;; 	(erase-buffer)
;; 	(compilation-mode)
;; 	(toggle-read-only nil)
;; 	(setq compilation-current-error nil)
;; 	(display-buffer (current-buffer))
;; 	(erl-spawn
;; 	  (erl-send-rpc (erl-target-node)
;; 			'distel
;; 			'eval_expression
;; 			(list "make:all([load])."))
;; 	  (erl-receive ()
;; 	      ((['rex ['ok string]]
;; 		(insert string))
;; 	       (['rex ['error reason]]
;; 		(insert reason))
;; 	       (other
;; 		(message "Unexpected: %S" other)))))))))

;; ;; just to illustrate how to use custom erlang compilation
;; ;; from within other modes
;; (add-hook 'foo-helper-mode-hook
;; 	  (lambda ()
;; 	    (define-key foo-helper-mode-map [f13]
;; 	      (lambda () (interactive)
;; 		(progn
;; 		  (my-erlang-compile))))))



;; final ui prefs
(toggle-colors-black)
(split-window-horizontally)
