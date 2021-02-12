;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                            ;;
;;       Elias de Jesus de Moraes             ;; 
;;                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(setq goenv "GOSOURCES")



;; disable gui component -1 or 1 to enable
(setq menu-bar 1)      
(setq scroll-bar -1)
(setq tooltip -1)
(setq tool-bar -1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(when (>= emacs-major-version 24)
(setq package-archives'(

          ("org"       . "http://orgmode.org/elpa/")
          ("melpa-mirrors" . "http://www.mirrorservice.org/sites/melpa.org/packages/")
          ("gnu"       . "http://elpa.gnu.org/packages/")
          ("melpa"     . "https://melpa.org/packages/")
          ("melpa-stable"     . "https://stable.melpa.org/packages/"))))

(package-initialize)

(unless (package-installed-p 'use-package )
    (package-refresh-contents))
    (package-install 'use-package)

(eval-when-compile
  (add-to-list 'load-path "~/.emacs.d")
  (require 'use-package))


(use-package auth-source
  :no-require t
  :config (setq auth-sources '("~/.authinfo.gpg" "~/.netrc")))


(use-package no-littering :ensure t)

(setq no-littering-etc-directory(expand-file-name "config/" user-emacs-directory))
(setq no-littering-var-directory(expand-file-name "data/" user-emacs-directory))
(require 'no-littering)

(require 'recentf)
(add-to-list 'recentf-exclude no-littering-var-directory)
(add-to-list 'recentf-exclude no-littering-etc-directory)

(use-package async
  :ensure t)

(async-bytecomp-package-mode 1)

(use-package auto-compile :ensure t)

(setq load-prefer-newer t)
(package-initialize)
(require 'auto-compile)
(auto-compile-on-load-mode)
(auto-compile-on-save-mode)

(defvar mode-line-bell-cached-string nil)
(defvar mode-line-bell-propertized-string nil)

(global-set-key (kbd "<mouse-2>") nil)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;            Themes and apparence                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(when window-system
  (menu-bar-mode menu-bar)             
  (scroll-bar-mode -1)            
  (tool-bar-mode -1)              
  (tooltip-mode -1))

  
(use-package ample-theme
   :init (progn (load-theme 'ample t t)
                (enable-theme 'ample))
   :defer t
   :ensure t)
 
 (require 'ample-theme)


(setq mouse-wheel-progressive-speed nil) 
(setq mouse-wheel-follow-mouse 't) 
(setq scroll-step 5) 

(setq mouse-yank-at-point nil)
(setq mouse-drag-copy-region nil)
(setq x-select-enable-primary nil)
(setq x-select-enable-clipboard t)
(setq select-active-regions t)
(global-set-key (kbd "<mouse-2>") nil)

(global-linum-mode t)
(setq linum-format " %3d ")

(global-auto-revert-mode t)

(add-to-list 'default-frame-alist '(fullscreen . maximized))
(cua-mode t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DASHBOARD CONFIG           ;;
;;                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(set-language-environment 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)


(use-package alert
  :defer 1
  :custom (alert-default-style 'libnotify))

(setq initial-major-mode 'text-mode)

;;(set-face-attribute 'default nil :font "Source Code Pro Medium")
;;(set-fontset-font t 'latin "Noto Sans")

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

(setq dashboard-banner-logo-title "Welcome to unicorn")

(setq dashboard-startup-banner "~/.emacs.d/unicorn/logo.png")
(setq dashboard-center-content t)
(setq dashboard-show-shortcuts nil)
(setq dashboard-items nil)

(setq dashboard-set-navigator t)
(setq dashboard-init-info "javascript is the cancer of the world !")
;(setq dashboard-set-footer nil)
(setq dashboard-projects-switch-function 'counsel-projectile-switch-project-by-name)


(use-package exec-path-from-shell :ensure t)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))


(use-package telephone-line
    :ensure t 
    :init
    (require 'telephone-line)
    :config 
    (telephone-line-mode 1))


(use-package rainbow-delimiters
  :ensure t)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(use-package switch-window
  :ensure t)

(require 'switch-window)

(use-package popwin
  :ensure t
  :config
  (popwin-mode t))

  (use-package neotree
  :ensure t
  :config
  (setq neo-theme 'nerd)
  (setq neo-window-width 55)
  (setq neo-smart-open t)

  (setq-default neo-show-hidden-files nil))



 (use-package undo-tree
	:ensure t
	:config
	(global-undo-tree-mode t))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Language suport                  ;;
;;                                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(use-package company
  :defer 0.5
  :delight
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay 0)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (global-company-mode t))


(use-package elpy
  :ensure t
  :init
  (elpy-enable))

(use-package go-mode
  :ensure t
  :init
  (autoload 'go-mode "go-mode" nil t)
  (add-hook 'go-mode-hook 'lsp-deferred)
  (add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode)))

(use-package go-autocomplete :ensure t) 

(defun auto-complete-for-go ()
   (auto-complete-mode 1))
 (add-hook 'go-mode-hook 'auto-complete-for-go)

(with-eval-after-load 'go-mode
  (require 'go-autocomplete))


(defun set-exec-path-from-shell-PATH ()
    (let ((path-from-shell (replace-regexp-in-string
         "[ \t\n]*$"
	 ""
	(shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
          (setenv "PATH" path-from-shell)
	      (setq eshell-path-env path-from-shell) ; for eshell users
	          (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))


(setenv "GOPATH" "~/GOSOURCES/gocode")

(use-package elixir-mode
  :ensure t
  :init
  (require 'elixir-mode)
  (add-to-list 'auto-mode-alist '("\\.elixir2\\'" . elixir-mode)))

(use-package lua-mode
  :delight "Λ "
  :mode "\\.lua\\'"
  :interpreter ("lua" . lua-mode))

(use-package mips-mode
    :ensure t 
    :mode 
    "\\.mips$"
    :init
    (require 'mips-mode))

(use-package sh-script
  :ensure nil
  :hook (after-save . executable-make-buffer-file-executable-if-script-p))

 (use-package yaml-mode
  :delight "ψ "
  :mode "\\.yml\\'"
  :interpreter ("yml" . yml-mode)) 


(use-package elisp-mode :ensure nil :delight "ξ ")




(use-package web-mode :ensure t)
(use-package company-web :ensure t)

(setq web-mode-enable-auto-pairing t)

(add-hook 'web-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-web-html))
                          (company-mode t)))

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))


(use-package js2-mode :ensure t)
(use-package js2-refactor :ensure t)
(use-package xref-js2 :ensure t)
(use-package json-mode :ensure t)

(add-hook 'js2-mode-hook #'js2-refactor-mode)

(add-hook 'js2-mode-hook (lambda ()
(add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; MAKE MODE  https://www.emacswiki.org/emacs/MakefileMode ; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'make-mode)
  
  (defconst makefile-nmake-statements
    `("!IF" "!ELSEIF" "!ELSE" "!ENDIF" "!MESSAGE" "!ERROR" "!INCLUDE" ,@makefile-statements)
    "List of keywords understood by nmake.")
  
  (defconst makefile-nmake-font-lock-keywords
    (makefile-make-font-lock-keywords
     makefile-var-use-regex
     makefile-nmake-statements
     t))
  
  (define-derived-mode makefile-nmake-mode makefile-mode "nMakefile"
    "An adapted `makefile-mode' that knows about nmake."
    (setq font-lock-defaults
          `(makefile-nmake-font-lock-keywords ,@(cdr font-lock-defaults))))

   (setq auto-mode-alist
        (cons '("\\.mak\\'" . makefile-nmake-mode) auto-mode-alist)) 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                  Shell                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   (use-package shell-pop
	:bind (("<f2>" . shell-pop))
	:config
        (setq shell-pop-shell-type (quote ("ansi-term" "*ansi-term*" (lambda nil (ansi-term shell-pop-term-shell)))))
        (setq shell-pop-shell-position "bottom")
	(setq shell-pop-term-shell "/bin/bash")		       
        (shell-pop--set-shell-type 'shell-pop-shell-type shell-pop-shell-type))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; KEY CONFIG                             ;;
;; CTR + x CTR + c  exit emacs            ;;
;; F1 neotree-show                       
;; 
;;
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package bind-key :ensure t)

(global-set-key (kbd "<f1>") 'neotree-show)


