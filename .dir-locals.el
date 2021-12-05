((nil . (
	 (org-roam-directory . "~/EPQ/Notes")
	 (org-roam-db-location . "~/EPQ/Notes/org-roam.db")
	 (eval git-auto-commit-mode 1)
	 (org-roam-dailies-capture-templates ("n" "default" entry "* %?" :if-new
					      (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n")
					      :unnarrowed t)
					     ("d" "diary" entry "* Diary entry%?\n** What have I done since the last entry?\n** What have I learned & how?\n** What worked well?\n** What would I do differently next time?\n" :if-new
					      (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n* Diary entry\n** What have I done since the last entry?\n** What have I learned & how?\n** What worked well?\n** What would I do differently next time?"))
					     )
	 (org-cite-global-bibliography "~/EPQ/Documents/bibliography.bib")
	 (org-bibtex-export-arbitrary-fields 't)
	 (org-bibtex-prefix . ""))))
