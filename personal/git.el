;; Find 10 most recent branches worked on when you've got more than a couple things in the air
(global-set-key (kbd "C-c C-g C-b") 'recent-branches)
(defun recent-branches ()
  (interactive)
  (shell-command "git for-each-ref --sort=-committerdate refs/heads/ | head -n 10" (switch-to-buffer-other-window (generate-new-buffer "**recent git branches**"))))
