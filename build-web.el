(require 'ox-publish)

(setq org-publish-project-alist
      (list
       (list "epq-project-docs"
	     :recursive t
	     :base-directory "./Web"
	     :publishing-directory "./Web-out"
	     :publishing-function 'org-html-publish-to-html)))

(org-publish-all t)

(message "Built website")
