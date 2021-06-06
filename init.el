;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
; (package-initialize)
;; called in packages.el

(let* ((root-dir (file-name-directory load-file-name))
       (personal-dir (expand-file-name "personal" root-dir)))
  (load (concat root-dir "packages.el"))
  (when (file-exists-p personal-dir)
    (message "Loading up your sweet config in %s" personal-dir)
    (mapc 'load (directory-files personal-dir 't "^[^#\.].*\\.el$"))))


(setq initial-frame-alist '((top . 0) (left . 0) (width . 200) (height . 80)))

; (setq package-load-list '(("cider" "0.8.1") all))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(helm-buffers-fuzzy-matching t)
 '(helm-completion-in-region-fuzzy-match t)
 '(helm-imenu-fuzzy-match t)
 '(helm-recentf-fuzzy-match t)
 '(org-agenda-files '())
 '(org-export-backends '(ascii html icalendar latex md odt))
 '(package-selected-packages
   '(
     ac-cider
     ac-slime
     ace-jump-mode
     align-cljlet
     atomic-chrome
     auto-complete
     bundler
     cider
     cider-decompile
     cider-eval-sexp-fu
     clj-refactor
     clojure-mode
     company
     company-web
     cucumber-goto-step
     deadgrep
     doom-modeline
     elein
     elisp-format
     elpy
     evil
     f
     feature-mode
     flx-ido
     flycheck prettier-js
     fzf
     git-commit-mode
     graphql-mode
     helm-ack
     helm-projectile
     htmlize
     js2-mode
     json-mode
     lispy
     magit
     multiple-cursors
     nodejs-repl
     org-kanban
     org-roam
     org-roam-server
     ox-reveal
     pickle
     projectile paredit
     projectile-rails
     projectile-ripgrep
     python-mode
     rainbow-delimiters
     robe
     rspec-mode
     ruby-tools
     slim-mode
     slime
     slime-company
     sml-mode
     solarized-theme
     srefactor
     web-mode
     yaxception
     )))
(put 'erase-buffer 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
