(menu-bar-mode -1)

;; Global linter
(global-flycheck-mode)

;; Use projectile for most moving around Emacs
(projectile-global-mode)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Multiple Cursor settings
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-S-c C-S-s") 'mc/edit-beginnings-of-lines)
(global-set-key (kbd "C-S-c C-S-r") 'mc/mark-all-in-region)

;; For courtesy pairing with Vim bindings. Toggles on and off.
(global-set-key (kbd "C-c C-e") 'evil-mode)

;; Super useful whitespace autotrim
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(global-set-key (kbd "M-j") 'join-line)
(global-set-key (kbd "M-g") 'goto-line)

;; Two interfaces for Magit (for git work)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch)

;; Display things
(global-display-line-numbers-mode)
(global-set-key (kbd "M-_")   (lambda () (interactive) (set-frame-font "DejaVu Sans Mono-12")))
(global-set-key (kbd "M-+")   (lambda () (interactive) (set-frame-font "DejaVu Sans Mono-14")))
(global-set-key (kbd "C-M-+") (lambda () (interactive) (set-frame-font "DejaVu Sans Mono-18")))

(global-set-key (kbd "C-S-s") 'isearch-forward-symbol-at-point)

;; Tabs == 2 spaces!
(global-set-key (kbd "TAB") "  ")

;; For Deadgrep searching anything in the entire project
(global-set-key (kbd "C-c TAB") #'deadgrep)

;; For quick and thorough search of file names
(global-set-key (kbd "C-c F") #'fzf)

;; IDO for further options to navigate Emacs
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

;(setq helm-M-x-fuzzy-match        t
;helm-projectile-fuzzy-match nil)

(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(global-set-key (kbd "M-o") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

(windmove-default-keybindings)

(setq exec-path (cons "/usr/local/bin" exec-path))
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))


(global-set-key (kbd "M-i") 'helm-imenu-in-all-buffers)
(custom-set-variables
  '(helm-imenu-fuzzy-match                t)
  '(helm-buffers-fuzzy-matching           t)
  '(helm-completion-in-region-fuzzy-match t)
  '(helm-recentf-fuzzy-match              t))

(setq create-lockfiles nil)

;; Surprisingly useful in macros for mass changes to a doc: Increment number
(global-set-key (kbd "C-c +") 'increment-number-at-point)
 (defun increment-number-at-point ()
      (interactive)
      (skip-chars-backward "0-9")
      (or (looking-at "[0-9]+")
          (error "No number at point"))
      (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))

;; Another surprisingly useful method to copy current buffer filename into kill ring. Great when needing to write up documentation about a file you're working in or sharing information with others about your work.
(defun xah-copy-file-path (&optional @dir-path-only-p)
  "Copy the current buffer's file path or dired path to `kill-ring'.
Result is full path.
If `universal-argument' is called first, copy only the dir path.

If in dired, copy the file/dir cursor is on, or marked files.

If a buffer is not file and not dired, copy value of `default-directory' (which is usually the “current” dir when that buffer was created)

URL `http://ergoemacs.org/emacs/emacs_copy_file_path.html'
Version 2017-09-01"
  (interactive "P")
  (let (($fpath
         (if (string-equal major-mode 'dired-mode)
             (progn
               (let (($result (mapconcat 'identity (dired-get-marked-files) "\n")))
                 (if (equal (length $result) 0)
                     (progn default-directory )
                   (progn $result))))
           (if (buffer-file-name)
               (buffer-file-name)
             (expand-file-name default-directory)))))
    (kill-new
     (if @dir-path-only-p
         (progn
           (message "Directory path copied: 「%s」" (file-name-directory $fpath))
           (file-name-directory $fpath))
       (progn
         (message "File path copied: 「%s」" $fpath)
         $fpath )))))
