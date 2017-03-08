;; ===== Emacs init.el =====
;; Or, I miss vim already(tm)

;; NOTE: As I'm still new to emacs, I annotate things that would be obivous to
;; regular emacs users in order to aid with learning.

;; Prelude to all other settings
;; =============================

;; Store customizations in separate file. Without this, emacs will add state to
;; this config, which makes it hard to version control.
(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

;; Add the melpa repositories. This assumes emacs >= 24, which comes packaged
;; with package.el.
(require 'package)
(push '("melpa" . "http://melpa.org/packages/")
      package-archives)
(push '("melpa-stable" . "http://stable.melpa.org/packages/")
      package-archives)
(package-initialize)

(defvar eos/did-refresh-packages nil
  "Flag for whether packages have been refreshed yet")

(defun install-pkgs (list)
  (dolist (pkg list)
    (progn
      (if (not (package-installed-p pkg))
          (progn
            (if (not eos/did-refresh-packages)
                (progn (package-refresh-contents)
                       (setq eos/did-refresh-packages t)))
            (package-install pkg))))))

(install-pkgs '(use-package))
;; Load use-package, used for loading packages everywhere else
(require 'use-package nil t)
;; Set to t to debug package loading or nil to disable
(setq use-package-verbose nil)

;; Appearance
;; ==========

;; Turn off the menu bar
(menu-bar-mode -1)
;; Disable toolbars in XEmacs
(tool-bar-mode -1)

;; Enable the mouse
(xterm-mouse-mode)

;; Enable line numbers
(global-linum-mode t)
;; Suffix a space to line numbering because we miss vim
(setq linum-format
      (lambda (line)
        (propertize
         (format (let
                     ((w (length (number-to-string (count-lines (point-min) (point-max))))))
                   (concat "%" (number-to-string w) "d ")) line) 'face 'linum)))

;; Set the font for XEmacs
(add-to-list 'default-frame-alist '(font . "Source Code Pro-15" ))
(set-face-attribute 'default t :font "Source Code Pro-15" )

;; Ensure terminals use UTF-8
(set-terminal-coding-system 'utf-8-unix)

;; airline-themes pulls in powerline, but doesn't require cl out-of-the box so
;; we do that manually. behelit is a decent out-of-the-box theme.
;; (require 'airline-themes)
;; (require 'cl)
;; (load-theme 'airline-behelit)
;; (require 'spaceline-config)
;; (spaceline-spacemacs-theme)
;; (powerline-default-separator)

;; Tweak monokai face colors that I prefer
(use-package ujelly-theme
  :ensure t
  :init
  (load-theme 'ujelly t)
  ;; (custom-set-faces
  ;;  '(default ((t (:background "#151515"))))
  ;;  '(flycheck-error ((t (:background nil))))
  ;;  '(flycheck-warning ((t (:background nil))))
  ;;  '(font-lock-string-face ((t (:foreground "#61ce3c")))))
  )

;; Eeeeeeevil
;; ==========

(use-package evil
  :ensure t
  :init
  (use-package evil-leader
    :ensure t
    :init
    (global-evil-leader-mode))
  (use-package evil-org
    :ensure t)
  (use-package evil-matchit
    :ensure t
    :init
    (global-evil-matchit-mode 1))
  (evil-mode 1)
  :config
  ;; Configure my preferred leader (space) and some simple shortcuts
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key "b" 'projectile-switch-to-buffer)
  (evil-leader/set-key "f" 'projectile-find-file)
  (evil-leader/set-key "p" 'projectile-switch-project)
  (evil-leader/set-key "t" (lambda() (interactive) (ansi-term "zsh")))
  ;; This escape strategy is the best I've found - using key-chord or
  ;; evil-escape introduces a noticeable lag/delay when using the prefix key,
  ;; this simulates vim's behavior (type the first letter, backtrack if the
  ;; combination appears.)
  (evil-define-command
   cofi/maybe-exit ()
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

  (define-key evil-insert-state-map "j" #'cofi/maybe-exit)
  (define-key evil-normal-state-map (kbd "TAB TAB") 'other-window))

;; Parens/bracket matching
(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode t))

;; Flycheck
;; ========
(use-package flycheck
  :ensure t
  :init
  (add-hook 'after-init-hook #'global-flycheck-mode)
  :config
  (use-package flycheck-haskell
    :ensure t
    :init
    (add-hook 'flycheck-mode-hook #'flycheck-haskell-setup)))

;; Org-Mode
;; ========
(use-package org
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((sh . t)
     )))

;; Ag
;; ==
(use-package ag
  :ensure t)

;; Projectile
;; ==========
(use-package projectile
  :ensure t
  :init
  (projectile-global-mode))

;; Haskell development
;; ===================
(use-package haskell-mode
  :ensure t
  :init
  (custom-set-variables '(haskell-process-type 'stack-ghci)))

;; Puppet
;; ======
(use-package puppet-mode
  :ensure t)

;; General-purpose settings
;; ========================
;; Use UTF-8 for all encoding
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

;; Never force typing 'yes', just 'y'
(defalias 'yes-or-no-p 'y-or-n-p)

;; Show newlines
(global-whitespace-newline-mode)

;; Turn off annoying background
(setq whitespace-style
      (quote (spaces tabs newline space-mark tab-mark newline-mark)))

;; Set custom newline character (it's the mathematical "not")
(setq whitespace-display-mappings
      '(
        (newline-mark 10 [172 10])
        (tab-mark 9 [9656 9])
        ))
