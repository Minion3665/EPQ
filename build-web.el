(require 'ox-publish)
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

(setq org-html-validation-link nil
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-head
      "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />")

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
	     :title "Skyler Turner's EPQ"
	     )))

(setq org-export-with-broken-links 'mark)
(org-publish-all t)

(message "Built website")
