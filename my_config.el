(provide 'my_config)

(setq inhibit-splash-screen t)

;; are we in gui window system or shell-based emacs?
(defvar *emacsapp-p* (window-system))

;; case-sensitive file find
(setq read-file-name-completion-ignore-case nil)

;; debug elisp
(setq debug-on-error t)

;; numbering
(line-number-mode 1)
(column-number-mode 1)

;; no backup files
(setq make-backup-files nil)

(global-set-key [f5] 'revert-buffer)

;; uniquify same filename
'(uniquify-buffer-name-style (quote forward) nil (uniquify))

;; delete selection when typing
(delete-selection-mode 1)

;; yes or no questions (y/n)
(fset 'yes-or-no-p 'y-or-n-p)

;; windmove
;(when (fboundp 'windmove-default-keybindings)
;  (windmove-default-keybindings))

;; to get rid of ^M chars
;(add-hook 'comint-output-filter-functions
;          'comint-strip-ctrl-m)

(setq mac-option-modifier 'meta)

;;; A quick & ugly PATH solution to Emacs on Mac OSX
(setenv "PATH" (concat "/usr/local/bin:"
                       "/usr/local/sbin:"
                       "/Users/brad/\.rvm/bin:"
                       "/Users/brad/\.gem/Ruby/1.8/bin:"
                       (getenv "PATH")))

;; color-theme
(add-to-list 'load-path "~/dev/emacs/color-theme") ;; Configuration for color-theme

;; Tweaking editing environment
(setq-default show-trailing-whitespace t)

;;(add-to-list 'default-frame-alist '(alpha . (100 70)))
(add-to-list 'default-frame-alist '(alpha . (100 100)))

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
;(when
;    (load
;     (expand-file-name "~/dev/emacs/elpa/package.el"))
;  (package-initialize))


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






;;; Erlang
(add-to-list 'load-path "~/dev/emacs/erlang") ;; Configurations for Erlang mode

;; Erlang mode to use
;(add-to-list 'load-path "~/dev/emacs/erlang/erlware-mode")  ; erlware
(add-to-list 'load-path "~/dev/emacs/erlang/erlang-mode") ; OTP symlink

;; rest of erlang mode stmts
(setq erlang-root-dir "/usr/local/lib/erlang")
(setq exec-path (cons "/usr/local/lib/erlang/bin" exec-path))
(require 'erlang-start)
(require 'erlang-flymake)
;; http://koansys.com/tech/emacs-hangs-on-flymake-under-os-x
(setq flymake-gui-warnings-enabled nil)

;; get erlang shell to start in other window
;(defvar inferior-erlang-display-buffer-any-frame 'nil)
;(add-hook 'erlang-shell-mode-hook
;          (lambda ()
;            (let* ((right-win (windmove-find-other-window 'right)))
;              (if (null right-win)
;                  (split-window-horizontally))
;              (set-window-buffer right-win inferior-erlang-buffer))))

(defvar erlang-inferior-shell-split-window nil)

(defun inferior-erlang-display-buffer (&optional select)
  "Make the inferior Erlang process visible.
The window is returned.

Should the optional argument SELECT be non-nil, the window is
selected.  Should the window be in another frame, that frame is raised.

Note, should the mouse pointer be places outside the raised frame, that
frame will become deselected before the next command."
  (interactive)
  (or (inferior-erlang-running-p)
      (error "No inferior Erlang process is running"))
  (let* ((win (inferior-erlang-window
               inferior-erlang-display-buffer-any-frame))
         (right-win (condition-case nil
                        (windmove-right)
                      (error
                       (split-window-horizontally)
                       (windmove-right))))
         (frames-p (fboundp 'selected-frame)))
     (let ((old-win (selected-window)))
      (save-excursion
        (set-window-buffer right-win inferior-erlang-buffer)
;        (select-window right-win)
;        (switch-to-buffer inferior-erlang-buffer)
        )
      (select-window old-win))
    (if select
	(select-window win))
    (sit-for 0)
    win))


(defun my-erlang-compile-includedir()
  (concat (inferior-erlang-compile-outdir) "../include"))

(defun my-erlang-compile (arg)
  "Compile the file in the current buffer.

With prefix arg, compiles for debug.

Should Erlang return `{error, nofile}' it could not load the object
module after completing the compilation.  This is due to a bug in the
compile command `c' when using the option `outdir'.

There exists two workarounds for this bug:

  1) Place the directory in the Erlang load path.

  2) Set the Emacs variable `erlang-compile-use-outdir' to nil.
     To do so, place the following line in your `~/.emacs'-file:
        (setq erlang-compile-use-outdir nil)"
  (interactive "P")
  (save-some-buffers)
  (inferior-erlang-prepare-for-input)
  (let* ((out-dir (inferior-erlang-compile-outdir))
         (include-dir (my-erlang-compile-includedir))
	 (noext (substring (buffer-file-name) 0 -4))
	 (opts (append (list (cons 'outdir out-dir))
                       (list (cons 'i include-dir))
		       (if current-prefix-arg
			   (list 'debug_info 'export_all))
		       erlang-compile-extra-opts))
	 end)
    (save-excursion
      (set-buffer inferior-erlang-buffer)
      (compilation-forget-errors))
    (setq end (inferior-erlang-send-command
	       (inferior-erlang-compute-compile-command noext opts)
	       nil))
    (sit-for 0)
    (inferior-erlang-wait-prompt)
    (save-excursion
      (set-buffer inferior-erlang-buffer)
      (setq compilation-error-list nil)
      (set-marker compilation-parsing-end end))
    (setq compilation-last-buffer inferior-erlang-buffer)))

(setq erlang-compile-function 'my-erlang-compile)

;; safe erlang indent level variable
'(safe-local-variable-values (quote ((erlang-indent-level . 4))))

;;; project-specific tweaks for Erlang
;;(require 'default_config) ;; Loading Erlang mode (dubdub & general config)
;;(require 'couch_config) ;; Loading Erlang mode (couchdb/cloudant config)
;;(require 'ditz_config) ;; Loading Erlang mode (itests config)
;;(require 'ericssontv_config) ;; Loading Erlang mode (ericsson tv config)
;;(require 'koth_config) ;; Loading Erlang mode (koth config)
;;(require 'sdutil_config) ;; Loading Erlang mode (scaling data utility config)
;;(require 'kontexa_config) ;; Loading Erlang mode (kontexa config)
(require 'heartbyte_config) ;; Loading Erlang mode (heartbyte config)

;; distel
(add-to-list 'load-path "~/dev/emacs/distel/elisp") ;; Distel package
(require 'distel) ;; Loading distel
(distel-setup)







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

;; php
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
;(require 'php-mode)

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



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-errline ((((class color)) (:background "DarkRed"))))
 '(flymake-warnline ((((class color)) (:background "DarkBlue")))))


;; final ui prefs
(toggle-colors-black)
(when *emacsapp-p*
  (split-window-horizontally))
