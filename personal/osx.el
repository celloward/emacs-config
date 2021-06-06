(when (eq system-type 'darwin)
  ;; Still got interference with switching the keys so I just have two meta keys, Command for normal things, and Option for when there's conflicts with OSX stuffs
  (defun fix-mac-keys ()
    (setq mac-option-modifier 'meta)
    (setq mac-command-modifier 'meta))
  (defun revert-mac-keys ()
    (setq mac-option-modifier 'meta)
    (setq mac-command-modifier 'super))
  (fix-mac-keys)
  ;; This requires me to use Option meta instead of Command meta (which pulls up Spotlight
  (global-set-key (kbd "M-SPC") 'just-one-space)

  (setq dired-use-ls-dired t
        insert-directory-program "/usr/local/bin/gls"
        dired-listing-switches "-aBhl --group-directories-first")

  (if (not (getenv "TERM_PROGRAM"))
      (setenv "PATH"
              (shell-command-to-string "source $HOME/.zshrc && printf $PATH"))))
