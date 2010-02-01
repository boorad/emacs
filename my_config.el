(provide 'my_config)

;; are we in aquamacs or other emacs?
(defvar *aquamacs-p* (boundp 'aquamacs-version))

;; debug elisp
(setq debug-on-error t)

;; numbering
(line-number-mode 1)
(column-number-mode 1)

;; no backup files
(setq make-backup-files nil)

(global-set-key [f5] 'revert-buffer)

;; to get rid of ^M chars
;(add-hook 'comint-output-filter-functions
;          'comint-strip-ctrl-m)

(setq mac-option-modifier 'meta)

;; color-theme
(add-to-list 'load-path "~/dev/emacs/color-theme") ;; Configuration for color-theme

;; Tweaking editing environment
(setq-default show-trailing-whitespace t)

;;(add-to-list 'default-frame-alist '(alpha . (100 70)))
(add-to-list 'default-frame-alist '(alpha . (100 100)))


;; Custom keys config
(add-to-list 'load-path "~/dev/emacs/custom_keys")
(require 'custom_keys_config) ;; custom key bindings


;; magit mode
(add-to-list 'load-path "~/dev/emacs/magit")
(require 'magit) ;; Loading magit


;; Whitespace package
(add-to-list 'load-path "~/dev/emacs/whitespace")
(require 'whitespace_config) ;; Loading whitespace


;; Autosave config
(add-to-list 'load-path "~/dev/emacs/autosave")
(require 'autosave_config) ;; Configures autosaving


;; Erlang
(add-to-list 'load-path "~/dev/emacs/erlang") ;; Configurations for Erlang mode

;; Erlang mode to use
(add-to-list 'load-path "~/dev/emacs/erlang/erlware-mode")  ; erlware
;;(add-to-list 'load-path "/opt/local/lib/erlang/lib/tools-2.6.4/emacs") ; OTP

;; rest of erlang mode stmts
(require 'erlang-start)
(setq erlang-man-root-dir "/opt/local")
(add-to-list 'exec-path "/opt/local/lib/erlang/bin")
(setq erlang-root-dir "/opt/local/lib/erlang")

;; get erlang shell to start in other window
;(defvar inferior-erlang-display-buffer-any-frame 'raise)
(add-hook 'erlang-shell-mode-hook
          (lambda ()
            (if (one-window-p)
                (split-window-horizontally))
            ;(when *aquamacs-p*
            ;  (aquamacs-delete-window))
            (set-window-buffer (other-window 1) inferior-erlang-buffer)))

;; fix for compiling to ../ebin
(setq erlang-compile-outdir "../ebin")

;;; project-specific tweaks for Erlang
;;(require 'default_config) ;; Loading Erlang mode (dubdub & general config)
(require 'couch_config) ;; Loading Erlang mode (couchdb config)
;;(require 'dynomite_config) ;; Loading Erlang mode (dynomite config)

;; distel
(add-to-list 'load-path "~/dev/emacs/distel/elisp") ;; Distel package
(require 'distel) ;; Loading distel
(distel-setup)


;; flymake (now included in erlware-erlang mode)
;(require 'flymake_config) ;; Loading flymake

;; flymake hacks
(defun flymake-can-syntax-check-file (file-name)
  "Determine whether we can syntax check FILE-NAME.
Return nil if we cannot, non-nil if we can."
  (if file-name
      (if (flymake-get-init-function file-name) t nil)
    nil))


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


;; haml/sass
(add-to-list 'load-path "~/dev/emacs/haml") ;; haml config
(require 'haml-mode)
(require 'sass-mode)


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


;; Java
(when *aquamacs-p*
  (add-to-list 'load-path (expand-file-name "~/dev/emacs/java"))
  (require 'my_java))


(add-to-list 'load-path "~/dev/emacs/sql") ;; sql config
(eval-after-load "sql"
  '(load-library "sql-indent"))


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
 '(read-file-name-completion-ignore-case nil)

 (when *aquamacs-p*
   '(aquamacs-save-options-on-quit nil)
   '(one-buffer-one-frame-mode nil nil (aquamacs-frame-setup)))
 '(jde-jdk-registry (quote (("1.6.0_17" . "/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/")))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-errline ((((class color)) (:background "DarkRed"))))
 '(flymake-warnline ((((class color)) (:background "DarkBlue")))))


;; final ui prefs
(toggle-colors-black)
(when *aquamacs-p*
  (split-window-horizontally))
