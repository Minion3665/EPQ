((nil . (
	 (org-roam-directory . "~/School/EPQ/Notes")
	 (org-roam-db-location . "~/School/EPQ/Notes/org-roam.db")
	 (eval git-auto-commit-mode 1)
	 (org-roam-capture-templates . '(
					 ("n" "default" plain "%?"
					  :target (file+head "${slug}.org"
							     "#+title: ${title}\n")
					  :unnarrowed t)
					 ("d" "diary" plain "%?"
					  :target (file+head "${slug}.diary.org"
							     "#+title: Diary entry for ${title}\n"))
					 ))
	 )))
