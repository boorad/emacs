(provide 'my_config)

(setq inhibit-splash-screen t)

;; are we in gui or terminal emacs?
(defvar *gui-p* (window-system))

;; mouse
(xterm-mouse-mode 1)

;; debug elisp
(setq debug-on-error t)

;; numbering
(line-number-mode 1)
(column-number-mode 1)
(add-to-list 'load-path "~/dev/emacs/linum")
(require 'linum+)
(global-linum-mode 1)
(setq linum-format "%d ")

;; no backup files
(setq make-backup-files nil)

;; Changes all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

;; delete selection when typing
(delete-selection-mode 1)

(global-set-key [f5] 'revert-buffer)

;; mouse scrolling
(defun up-slightly () (interactive) (scroll-up 3))
(defun down-slightly () (interactive) (scroll-down 3))
(global-set-key (kbd "<mouse-4>") 'down-slightly)
(global-set-key (kbd "<mouse-5>") 'up-slightly)

;; to get rid of ^M chars
;(add-hook 'comint-output-filter-functions
;          'comint-strip-ctrl-m)

(setq mac-option-modifier 'meta)

;; highlight current line
(global-hl-line-mode 1)
(set-face-background 'hl-line "#323232")

;; color-theme
(add-to-list 'load-path "~/dev/emacs/color-theme") ;; Configuration for color-theme

;; Tweaking editing environment
(setq-default show-trailing-whitespace t)

;;(add-to-list 'default-frame-alist '(alpha . (100 70)))
(add-to-list 'default-frame-alist '(alpha . (100 100)))

;; case-sensitive file-name-completion
(setq read-file-name-completion-ignore-case nil)

;; Custom keys config
(add-to-list 'load-path "~/dev/emacs/custom_keys")
(require 'custom_keys_config) ;; custom key bindings

;; Popup
(add-to-list 'load-path "~/dev/emacs/popup")
(require 'popup)

;; Autocomplete mode
(add-to-list 'load-path "~/dev/emacs/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/dev/emacs/auto-complete/dict")
(ac-config-default)

;; magit mode
(add-to-list 'load-path "~/dev/emacs/magit")
(require 'magit) ;; Loading magit


;; Whitespace package
(add-to-list 'load-path "~/dev/emacs/whitespace")
(require 'whitespace_config) ;; Loading whitespace


;; Autosave config
(add-to-list 'load-path "~/dev/emacs/autosave")
(require 'autosave_config) ;; Configures autosaving

;; ;;; Erlang
;; (add-to-list 'load-path "~/dev/emacs/erlang") ;; Configurations for Erlang mode

;; ;; Erlang mode to use
;; ;(add-to-list 'load-path "~/dev/emacs/erlang/erlware-mode")  ; erlware
;; (add-to-list 'load-path "~/dev/emacs/erlang/erlang-mode") ; OTP symlink

;; ;; rest of erlang mode stmts
;; (setq erlang-root-dir "/usr/local/lib/erlang")
;; (setq exec-path (cons "/usr/local/lib/erlang/bin" exec-path))
;; (require 'erlang-start)
;; (require 'erlang-flymake)

;; ;; extra erlang compile options
;; ;;(setq erlang-compile-extra-opts
;; ;;      (list
;; ;;       (cons 'i (inferior-erlang-compile-includedir))
;; ;;       'debug_info))


;; ;; safe erlang indent level variable
;; '(safe-local-variable-values (quote ((erlang-indent-level . 4))))
;; ||#

;; ;;; project-specific tweaks for Erlang
;; ;;(require 'default_config) ;; Loading Erlang mode (dubdub & general config)
;; ;;(require 'couch_config) ;; Loading Erlang mode (couchdb/cloudant config)
;; ;;(require 'ditz_config) ;; Loading Erlang mode (itests config)
;; ;;(require 'ericssontv_config) ;; Loading Erlang mode (ericsson tv config)
;; ;;(require 'koth_config) ;; Loading Erlang mode (koth config)
;; (require 'heartbyte_config)
;; ;;(require 'reflex_config)

;; ;(add-to-list 'load-path "~/dev/emacs/erlang/my_erlang_compile")
;; (require 'my_erlang_compile)

;; ; Erlang auto-complete
;; (add-to-list 'ac-modes 'erlang-mode)

;; ;; get erlang shell to start in other window
;; ;(defvar inferior-erlang-display-buffer-any-frame 'raise)
;; (add-hook 'erlang-shell-mode-hook
;;           (lambda ()
;;             (if (one-window-p)
;;                 (split-window-horizontally))
;;             ;(when *gui-p*
;;             ;  (aquamacs-delete-window))
;;             (set-window-buffer (other-window 1) inferior-erlang-buffer)))

;; ;; distel
;; (add-to-list 'load-path "~/dev/emacs/distel/elisp") ;; Distel package
;; (require 'distel) ;; Loading distel
;; (distel-setup)




;; igrep
(add-to-list 'load-path "~/dev/emacs/igrep") ;; igrep
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


;; highlight-80+
(add-to-list 'load-path "~/dev/emacs/highlight-80+")
(require 'highlight-80+)


;; haml
(add-to-list 'load-path "~/dev/emacs/haml") ;; haml config
(require 'haml-mode)
;(require 'sass-mode)

;; sass/scss
(add-to-list 'load-path (expand-file-name "~/dev/emacs/scss"))
;(require 'scss-mode)
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

;; less
(add-to-list 'load-path "~/dev/emacs/less-css") ;; less config
(setq exec-path (cons (expand-file-name "~/.rvm/gems/ruby-1.9.3-p545/bin") exec-path))
(require 'less-css-mode)
(setq less-css-compile-at-save t)

;; undo-tree
(add-to-list 'load-path "~/dev/emacs/undo")
(require 'undo-tree)


;; tab lovin'
(setq-default indent-tabs-mode nil) ; always replace tabs with spaces
(setq-default tab-width 8) ; set tab width to 4 for all buffers


;; refresh file
;; from http://www.stokebloke.com/wordpress/2008/04/17/emacs-refresh-f5-key/
(defun refresh-file ()
  (interactive)
  (revert-buffer t t t)
  )


;; Python
(add-to-list 'load-path "~/dev/emacs/python")
(require 'my-python-compile)


;; Clojure
(add-to-list 'load-path "~/dev/emacs/clojure")
(require 'clojure-mode)


(add-to-list 'load-path "~/dev/emacs/sql") ;; sql config
(eval-after-load "sql"
  '(load-library "sql-indent"))


;; Puppet
(add-to-list 'load-path "~/dev/emacs/puppet")
(require 'puppet-mode)

;; PHP
(add-to-list 'load-path "~/dev/emacs/php")
(require 'php-mode)

;; S - string manipulation
(add-to-list 'load-path "~/dev/emacs/s")
(require 's)

;; Gradle
(add-to-list 'load-path "~/dev/emacs/gradle")
(require 'gradle-mode)

;; irc
(require 'erc)

;;; D mode
;(setq load-path (cons "/opt/local/share/emacs/site-lisp/d" load-path))
;
;(autoload 'd-mode "d-mode"
;  "Major mode for editing D code." t)
;(setq auto-mode-alist (cons '( "\\.d\\'" . d-mode ) auto-mode-alist ))
;;(autoload 'dlint-minor-mode "dlint" nil t)
;;(add-hook 'd-mode-hook (lambda () (dlint-minor-mode 1)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.

 ;; case-sensitive find file
 '(read-file-name-completion-ignore-case nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-errline ((((class color)) (:background "DarkRed"))))
 '(flymake-warnline ((((class color)) (:background "DarkBlue")))))

;; final ui prefs
(toggle-colors-black)
