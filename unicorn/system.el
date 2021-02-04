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




;(use-package assync : ensure t)
;(async-bytecomp-package-mode 1)


