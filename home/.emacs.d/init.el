; ===== Emacs init.el =====
; Or, I miss vim already(tm)

; NOTE: As I'm still new to emacs, I annotate things that would be obivous to
; regular emacs users in order to aid with learning.

; Prelude to all other settings
; =============================

; Store customizations in separate file. Without this, emacs will add state to
; this config, which makes it hard to version control.
(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

; Add the melpa repositories. This assumes emacs >= 24, which comes packaged
; with package.el.
(require 'package)
(push '("melpa" . "http://melpa.org/packages/")
      package-archives)
(push '("melpa-stable" . "http://stable.melpa.org/packages/")
      package-archives)
(package-initialize)

; Define list of packages we want...
(defvar my/install-packages
  '(
    ag
    evil
    evil-leader
    flycheck
    flycheck-haskell
    haskell-mode
    ujelly-theme
    puppet-mode
    projectile
    ))

; ...and install them if needed.
(dolist (pack my/install-packages)
  (unless (package-installed-p pack)
    (package-install pack)))

; Eeeeeeevil
; ==========

; Bootstrap evil and initialize the leader plugin, because obivously
(require 'evil)
(require 'evil-leader)
(global-evil-leader-mode)
(evil-mode 1)

; Configure my preferred leader (space) and some simple shortcuts
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key "b" 'projectile-switch-to-buffer)
(evil-leader/set-key "f" 'projectile-find-file)
(evil-leader/set-key "p" 'projectile-switch-project)
(evil-leader/set-key "t" '(lambda() (interactive) (ansi-term "zsh")))

; This escape strategy is the best I've found - using key-chord or
; evil-escape introduces a noticeable lag/delay when using the prefix key,
; this simulates vim's behavior (type the first letter, backtrack if the
; combination appears.)
(define-key evil-insert-state-map "j" #'cofi/maybe-exit)

(evil-define-command cofi/maybe-exit ()
  :repeat change
  (interactive)
  (let ((modified (buffer-modified-p)))
    (insert "j")
    (let ((evt (read-event (format "Insert %c to exit insert state" ?j)
                           nil 0.5)))
      (cond
       ((null evt) (message ""))
       ((and (integerp evt) (char-equal evt ?k))
        (delete-char -1)
        (set-buffer-modified-p modified)
        (push 'escape unread-command-events))
       (t (setq unread-command-events (append unread-command-events
                                              (list evt))))))))

; Appearance
; ==========

; Set the font for XEmacs
(add-to-list 'default-frame-alist '(font . "Source Code Pro-15" ))
(set-face-attribute 'default t :font "Source Code Pro-15" )

; Ensure terminals use UTF-8
(set-terminal-coding-system 'utf-8-unix)

; airline-themes pulls in powerline, but doesn't require cl out-of-the box so
; we do that manually. behelit is a decent out-of-the-box theme.
; (require 'airline-themes)
; (require 'cl)
; (load-theme 'airline-behelit)
; (require 'spaceline-config)
; (spaceline-spacemacs-theme)
; (powerline-default-separator)

; Tweak monokai face colors that I prefer
(load-theme 'ujelly t)
; (custom-set-faces
;  '(default ((t (:background "#151515"))))
;  '(flycheck-error ((t (:background nil))))
;  '(flycheck-warning ((t (:background nil))))
;  '(font-lock-string-face ((t (:foreground "#61ce3c")))))

; Flycheck
; ========
(add-hook 'after-init-hook #'global-flycheck-mode)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))

; Org-Mode
; ========
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sh . t)
   ))

; Projectile
; ==========
(projectile-global-mode)

; Haskell development
; ===================
(custom-set-variables '(haskell-process-type 'stack-ghci))

; General-purpose settings
; ========================

; Turn off the menu bar
(menu-bar-mode -1)
; Disable toolbars in XEmacs
(tool-bar-mode -1)

; Enable the mouse
(xterm-mouse-mode)

; Enable line numbers
(global-linum-mode t)
; Suffix a space to line numbering because we miss vim
(setq linum-format
  (lambda (line)
    (propertize
      (format (let
                ((w (length (number-to-string (count-lines (point-min) (point-max))))))
                (concat "%" (number-to-string w) "d ")) line) 'face 'linum)))

; Use UTF-8 for all encoding
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

; Never force typing 'yes', just 'y'
(defalias 'yes-or-no-p 'y-or-n-p)

; Show newlines
(global-whitespace-newline-mode)

; Turn off annoying background
(setq whitespace-style
      (quote (spaces tabs newline space-mark tab-mark newline-mark)))

; Set custom newline character (it's the mathematical "not")
(setq whitespace-display-mappings
      '(
        (newline-mark 10 [172 10])
        (tab-mark 9 [9656 9])
        ))
