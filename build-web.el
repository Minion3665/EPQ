(require 'ox-publish)

(setq org-html-validation-link nil
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />")

(setq org-publish-project-alist
      (list
       (list "epq-project-docs"
	     :recursive t
	     :base-directory "./Web"
	     :publishing-directory "./Web-out"
	     :publishing-function 'org-html-publish-to-html
	     :auto-sitemap t
	     :with-author nil
	     :with-creator nil
	     :section-numbers nil
	     )))

(org-publish-all t)

(message "Built website")
