(require 'ox-publish)

(setq org-html-validate-link nil)

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
