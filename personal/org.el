(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)

;; Org Babel Language Setup
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (org . t)
   (lilypond . t)
   (ruby . t)))

(setq org-replace-disputed-keys t)

(setq org-export-global-macros
 '(("cleanheaders" .
    "#+LATEX_HEADER: \\usepackage[margin=1in]{geometry}\n#+OPTIONS: num:nil\n#+OPTIONS: toc:nil\n#+OPTIONS: author:nil\n#+OPTIONS: date:nil")
   ("cleanlandscape" .
    "#+LATEX_HEADER: \\usepackage[margin=1in, landscape]{geometry}\n#+OPTIONS: num:nil\n#+OPTIONS: toc:nil\n#+OPTIONS: author:nil\n#+OPTIONS: date:nil")))

(setq org-todo-keywords
      '((sequence "TODO" "IN PROGRESS" "DONE")
	(sequence "BACKLOG(b!)" "IN PROGRESS(p!)" "IN REVIEW(r!)" "REJECTEDBY QA(j!)" "|" "READY FOR QA(q!)" "QA IN PROGRESS(a!)" "DONE(d!)")
	))

(setq org-log-into-drawer "LOGBOOK")

;; Make parent TODOs resolve when all children TODOs resolve
(defun org-summary-todo (n-done n-not-done)
       "Switch entry to DONE when all subentries are done, to TODO otherwise."
       (let (org-log-done org-log-states)   ; turn off logging
         (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

;; Hack to enable formatting on bits of a word
(defun insert-zero-width-space ()
  (interactive)
  (insert-char #x200b))

;; Unocmmenting causes init problems
;; (define-key org-mode-map (kbd "C-*") 'insert-zero-width-space)

(setq org-emphasis-regexp-components ; recognizes said zero-width space as a boundary for formatting
      '("   ('\"{\x200B" "-     .,:!?;'\")}\\[\x200B" "
,\"'" "." 1))

;; Makes underscores act as underscores, not as italic modifiers
(setq org-use-sub-superscripts '{})

;; Vanity

(add-hook 'org-mode-hook (lambda () (variable-pitch-mode t)))
(add-hook 'org-mode-hook 'visual-line-mode)

(setq org-startup-indented t
      org-pretty-entities t
      org-hide-emphasis-markers t
      org-fontify-whole-heading-line t
      org-fontify-done-headline t
      org-fontify-quote-and-verse-blocks t
      org-image-actual-width nil)

;; Some front end changes to org mode docs
(custom-theme-set-faces
 'user
 '(variable-pitch ((t (:family "ETBembo" :height 140 :weight light))))
 '(fixed-pitch ((t ( :family "Monaco" :slant normal :weight normal :height 0.8 :width normal))))
 '(org-code ((t (:inherit (shadow fixed-pitch)))))
 '(org-src-block-faces ((t (:inherit (shadow fixed-pitch)))))
 '(org-block ((t (:inherit fixed-pitch))))
 '(org-table ((t (:inherit fixed-pitch))))
 '(org-link ((t (:inherit fixed-pitch))))
 '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
 '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold))))
 '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-property-value ((t (:inherit fixed-pitch))) t)
 '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-verbatim ((t (:inherit (shadow fixed-pitch)))))
 '(org-level-1 ((t (:inherit outline-1 :height 1.3 :weight bold))))
 '(org-level-2 ((t (:inherit outline-1 :height 1.2 :weight bold))))
 '(org-level-3 ((t (:inherit outline-1 :height 1.1 :weight bold))))
 '(org-level-4 ((t (:inherit outline-1 :height 1.0 :weight bold))))
 '(org-level-5 ((t (:inherit outline-1 :height 1.0 :weight bold)))))

;; Convert MD into Org. Requires Pandoc (https://pandoc.org/)
(defun markdown-convert-buffer-to-org ()
    "Convert the current buffer's content from markdown to orgmode format and save it with the current buffer's file name but with .org extension."
    (interactive)
    (shell-command-on-region (point-min) (point-max)
                             (format "pandoc -f markdown -t org -o %s"
                                     (concat (file-name-sans-extension (buffer-name)) ".org"))))

;; Fetches the specified issue number from the 'my-repo' repo and saves in a folder '~/my-work/issues' with a file name of "my-work-issue-<issue-number>"
;; (defun fetch-my-issue ()
;;   (interactive)
;;   (org-fetch-gh-issue "~/my-repo/" "~/my-work/issues/" "my-work"))

;; The magic for the above. Requires Github CLI with permissions in the target repo.
;; Also requires Pandoc as it relies on markdown-convert-buffer-to-org
(defun org-fetch-gh-issue (source-filepath destination-filepath &optional file-prefix)
  (interactive)
  (let ((issue-number (read-from-minibuffer "Issue number to pull: ")))
    (let ((prefix (if file-prefix file-prefix "")))
          (let ((file-base (format "%s-issue-%s" prefix issue-number)))
       	  (let ((interim-buffer (concat file-base ".md"))
  		(destination-buffer (concat file-base ".org")))
            (let ((default-directory source-filepath))
	      (shell-command (format "gh issue view %s" issue-number) interim-buffer))
			(set-buffer interim-buffer)
			(markdown-mode)
			(markdown-convert-buffer-to-org)
			(shell-command (format "mv %s %s" destination-buffer destination-filepath))
			(kill-buffer interim-buffer)
			(find-file (format "%s%s" destination-filepath destination-buffer)))))

    (goto-char (point-min))
    (org-ctrl-c-star)
    (while (search-forward "title: ")
      (replace-match ""))
))
