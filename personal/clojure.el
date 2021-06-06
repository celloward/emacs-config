(add-hook 'cider-mode-hook #'eldoc-mode)

(require 'ac-cider)
(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'auto-complete-mode)
(add-hook 'cider-mode-hook 'auto-complete-mode)
(eval-after-load "auto-complete"
                 '(progn
                   '(add-to-list 'ac-modes 'cider-mode)
                   '(add-to-list 'ac-modes 'cider-repl-mode)))

(setq cider-show-error-buffer nil) ;; Not ideal, but I was having a performance issue

(defun set-auto-complete-as-completion-at-point-function ()
    (setq completion-at-point-functions '(auto-complete)))
(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)

(add-hook 'cider-repl-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)

(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook (lambda ()
			       (local-set-key (kbd "C-c M-l") 'align-cljlet)))
(add-hook 'cider-repl-mode-hook 'paredit-mode)
;(add-hook 'clojure-mode-hook 'linum-mode)

;(eval-after-load "cider"
;  '(progn
;     (define-key cider-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc)))

(add-hook 'clojure-mode-hook 'column-number-mode)

(require 'rainbow-delimiters)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)

(dolist (macro '(fresh cond run run* for-all describe it with-env for-map
		       dom/div dom/p dom/button dom/span))
    (put-clojure-indent macro 'defun))

(require 'clojure-mode)
(define-clojure-indent
  (defroutes 'defun)
  (GET 2)
  (POST 2)
  (PUT 2)
  (DELETE 2)
  (HEAD 2)
  (ANY 2)
  (context 2))

(require 'clj-refactor)
(add-hook 'clojure-mode-hook (lambda ()
			       (clj-refactor-mode 1)
			       (cljr-add-keybindings-with-prefix "C-c M-f")))

(define-key clojure-mode-map (kbd "M-Q") 'align-cljlet)

(add-hook
 'clojure-mode-hook
 (lambda ()
   (setq-local fill-column 118)
   (setq-local clojure-docstring-fill-column 118)))

(setq cider-repl-history-file "~/.cider-repl-history")

(setq nrepl-hide-special-buffers nil) ; used to be t?
