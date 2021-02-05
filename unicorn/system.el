;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                            ;;
;;                                            ;; 
;;                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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
;;                                                                ;;
;;                                                                ;;
;;            Themes and apparence                                ;;
;;                                                                ;;
;;                                                                ;;
;;                                                                ;;
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

(setq initial-major-mode 'text-mode)

(set-face-attribute 'default nil :font "Source Code Pro Medium")
(set-fontset-font t 'latin "Noto Sans")

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

(setq dashboard-banner-logo-title "Welcome to unicorn -")

(setq dashboard-startup-banner "~/.emacs.d/unicorn/logo.png")
(setq dashboard-center-content t)
(setq dashboard-show-shortcuts nil)
(setq dashboard-items nil)

(setq dashboard-set-navigator t)
;(setq dashboard-init-info "javascript is the cancer of the world !")
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
  (setq neo-window-width 45)
  ;; auto open on current file
  (setq neo-smart-open t)

  (setq-default neo-show-hidden-files nil))

(tool-bar-add-item "home" 'neotree-toggle
               'Files
               :help   "File Explorer")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Language suport                  ;;
;;                                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

(use-package elixir-mode
  :ensure t
  :init
  (require 'elixir-mode)
  (add-to-list 'auto-mode-alist '("\\.elixir2\\'" . elixir-mode)))

(use-package lua-mode
   :ensure t
   :init 
   (require 'lua-mode))

(use-package mips-mode
    :ensure t 
    :mode 
    "\\.mips$"
    :init
    (require 'mips-mode))


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
;;  KEY CONFIG                            ;;
;;                                        ;;
;;                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;