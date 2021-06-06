(setq ruby-insert-encoding-magic-comment nil)

(projectile-rails-global-mode)

(define-key projectile-rails-mode-map (kbd "C-c r") 'projectile-rails-command-map)

(add-hook 'ruby-mode-hook 'superword-mode)
(add-hook 'after-init-hook 'inf-ruby-switch-setup)
(add-hook 'compilation-filter-hook 'inf-ruby-auto-enter) ; Avoid having to C-x C-q when entering Pry

;; ERB
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))

(eval-after-load "web-mode"
  '(progn
     (setq web-mode-enable-auto-closing nil)
     (setq web-mode-markup-indent-offset 2)
     (setq web-mode-markup-indent-pairing 2)))

;; Bundle Install
(add-hook 'ruby-mode-hook
	  (define-key ruby-mode-map (kbd "C-c b i") 'bundle-install)
)

;; Add frozen string literal on command
(define-key ruby-mode-map (kbd "C-c m") 'add-magic-comment)
(defun add-magic-comment ()
  (interactive)
  (current-buffer)
  (beginning-of-buffer)
  (insert "# frozen_string_literal: true")
  (newline)
  (newline))

;; Nice jumping to definitions. Requires a console up and running
;; M-. jumps to definition of object at point
;; M-, goes back to previous point before jump
(add-hook 'ruby-mode-hook 'robe-mode)

;; Broken on my machine right now
;; Company Mode (Robe)
  ;; (eval-after-load 'company
  ;; '(push 'company-robe company-backends))

;; Autocompletion
;; (add-hook 'robe-mode-hook 'ac-robe-setup)
