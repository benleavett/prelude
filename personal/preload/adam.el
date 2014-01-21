;;

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)


;;; Add in extra repositories/packages
(require 'package)
(setq package-archives '( ("gnu" . "http://elpa.gnu.org/packages/")
                          ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

(when (not package-archive-contents) (package-refresh-contents))

(dolist (p '(multiple-cursors
             clj-refactor
             align-cljlet
             git-gutter-fringe))
  (when (not (package-installed-p p))
    (package-install p)))

(custom-set-faces
 '(default ((t (:background "black"
                            :foreground "white"
                            :weight normal
                            :height 80
                            :width normal
                            :family "DejaVu Sans Mono")))))

(set-frame-parameter (selected-frame) 'alpha '(90 90))
(add-to-list 'default-frame-alist '(alpha 90 90))

;;; Sloppy focus
(setq mouse-autoselect-window t)

;; Custom key bindings
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)

;;; Make M-SPC multiline by default
(global-set-key (kbd "M-SPC") (lambda () (interactive) (just-one-space -1)))

;;; Pressing enter does a reindent too by default
(global-set-key "\C-m" 'newline-and-indent)

;;; Info about at which point I would like the screen to split
;;; vertically vs horizontally
(setq split-height-threshold nil)
(setq split-width-threshold 180)

(setq prelude-guru nil)
(setq prelude-flyspell nil)
(setq prelude-whitespace nil)

(disable-theme 'zenburn)

;; Git gutter configuration ----------------------------------------------
(require 'git-gutter)
(global-git-gutter-mode t)
(setq git-gutter:modified-sign "~")
(setq git-gutter:added-sign    "+") 
(setq git-gutter:deleted-sign  "-")

(set-face-foreground 'git-gutter:modified "purple")
(set-face-foreground 'git-gutter:added "green")
(set-face-foreground 'git-gutter:deleted "red")

;; Stage current hunk
(global-set-key (kbd "C-x v s") 'git-gutter:stage-hunk)

;; Revert current hunk
(global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk)

;; Clojure refactor and formatting configuration --------------------------
(require 'clj-refactor)
(add-hook 'clojure-mode-hook (lambda ()
                               (clj-refactor-mode 1)
                               (cljr-add-keybindings-with-prefix "C-c C-m")
                               (define-key clojure-mode-map
                                 (kbd "C-q") 'align-cljlet)))


(xterm-mouse-mode)

;;
