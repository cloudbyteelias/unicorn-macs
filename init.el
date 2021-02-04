
(defvar  unicorn
		(concat user-emacs-directory
        (convert-standard-filename "unicorn/")))


(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))


(load(concat unicorn "system.el"))