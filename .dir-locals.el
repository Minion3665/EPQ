((nil . (
	 (org-roam-directory . "~/School/EPQ/Notes")
	 (org-roam-db-location . "~/School/EPQ/Notes/org-roam.db")
	 (eval git-auto-commit-mode 1)
	 (org-roam-dailies-capture-templates ("n" "default" plain "%?"
					      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
								 "#+title: ${title}\n")
					      :unnarrowed t)
					     ("d" "diary" plain "%?"
					      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
								 "#+title: Diary entry for ${title}\n* What have I done since the last entry?\n* What have I learned & how?\n* What worked well?\n* What would I do differently next time?\n")
					      :unnarrowed t)))))
