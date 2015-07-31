
;; ===== Emacs init.el =====
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
      evil
      evil-leader
      evil-escape
      flycheck
      haskell-mode
      puppet-mode
      smart-mode-line
      powerline
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
(evil-leader/set-key "e" 'find-file)

; Load smart-mode-line and its powerline theme. These lines require both
; smart-mode-line and powerline packages.
(setq sml/theme 'dark)
(sml/setup)
(powerline-default-theme)

; Use the evil-escape plugin to use a custom escape sequence. I tried using
; key-chords for this originally, but the delay is too noticable.
(setq-default evil-escape-key-sequence "jk")
(evil-escape-mode)

; The following line is an example of how I had to tune the delay to work...
; (setq key-chord-two-keys-delay 0.015)

; Flycheck
; ========
(add-hook 'after-init-hook #'global-flycheck-mode)

; Helm
; ====
(require 'helm-config)

; General-purpose settings
; ========================

; My custom theme
(load-theme 'gerard)

; Turn off the menu bar
(menu-bar-mode -1)

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
