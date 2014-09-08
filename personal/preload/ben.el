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

(set-frame-parameter (selected-frame) 'alpha '(100 90))
(add-to-list 'default-frame-alist '(alpha 100 90))

;;; Sloppy focus
(setq mouse-autoselect-window t)

;;; Don't open files in separate windows
(setq ns-pop-up-frames nil)

;; Custom key bindings
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/unmark-next-like-this)

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

(customize-variable (quote tab-stop-list))

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
                               (smartparens-mode 0)
                               (paredit-mode 1)
                               (define-key clojure-mode-map
                                 (kbd "C-q") 'align-cljlet)))


(xterm-mouse-mode)

(add-to-list 'default-frame-alist '(left . 0))
(add-to-list 'default-frame-alist '(top . 0))

;; with monitor
(add-to-list 'default-frame-alist '(height . 100))
(add-to-list 'default-frame-alist '(width . 160))

;; no monitor
;(add-to-list 'default-frame-alist '(height . 50))
;(add-to-list 'default-frame-alist '(width . 160))

(eval-after-load "grep"
  '(grep-compute-defaults))

(defun find-git-root (&optional dir)
  (unless dir (setq dir (expand-file-name (file-name-directory (buffer-file-name)))))
  (let ((parent (expand-file-name ".." dir)))
    (unless (equal parent dir)
      (if (file-exists-p (expand-file-name ".git" dir))
          dir
        (find-git-root parent)))))

(defun rgrep-token-under-point-in-project-root-dir ()
  (interactive)
  (rgrep (current-word) 
         (concat "*." (file-name-extension (buffer-file-name)))
         (find-git-root))
  (switch-to-buffer-other-frame "*grep*"))

(global-set-key (kbd "M-#") 'rgrep-token-under-point-in-project-root-dir)

(add-to-list 'load-path "~/.emacs.d/window-number")
(require 'window-number)

(window-number-meta-mode)

(desktop-save-mode 1)
;;
