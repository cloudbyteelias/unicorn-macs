;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                            ;;
;;                                            ;; 
;;                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(defvar unicorn
  (concat user-emacs-directory
   (convert-standard-filename "unicorn/")))

(defvar  package-enable-at-startup nil)

(package-initialize)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(require 'package)

;(when (>= emacs-major-version 24)
; (require 'package)
; (add-to-list
;  'package-archives '("melpa" . "https://melpa.org/packages/")t))


(when (>= emacs-major-version 24)
(setq package-archives'(

          ("org"       . "http://orgmode.org/elpa/")
          ("melpa-mirrors" . "http://www.mirrorservice.org/sites/melpa.org/packages/")
          ("gnu"       . "http://elpa.gnu.org/packages/")
          ("melpa"     . "https://melpa.org/packages/")
          ("melpa-stable"     . "https://stable.melpa.org/packages/"))))


(unless package-archive-contents
 (package-refresh-contents))


;(unless (package-installed-p 'use-package )
;   (package-install 'use-package))

;(require 'use-package) 
