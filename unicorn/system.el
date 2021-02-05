;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                            ;;
;;                                            ;; 
;;                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq package-enable-at-startup nil)

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

(if window-system
    (tool-bar-mode -1)
    (toggle-scroll-bar -1)
    (menu-bar-mode -1) 
)

(use-package ample-theme
  :init (progn (load-theme 'ample t t)
               (enable-theme 'ample))
  :defer t
  :ensure t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DASHBOARD CONFIG           ;;
;;                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
(setq dashboard-init-info "javascript is the cancer of the world !")
;(setq dashboard-set-footer nil)
(setq dashboard-projects-switch-function 'counsel-projectile-switch-project-by-name)







;(use-package assync : ensure t)
;(async-bytecomp-package-mode 1)


