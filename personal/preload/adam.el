;;

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

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

(xterm-mouse-mode)

;;
