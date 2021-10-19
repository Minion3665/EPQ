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
(package-install 'org)
(package-install 'org-roam)

(require 'org-roam)

(setq org-roam-directory (file-truename "./content"))
(setq org-id-link-to-org-use-id t)
;; (org-roam-db-autosync-mode)

(setq org-id-extra-files (org-roam-list-files))

(defun org-html--reference (datum info &optional named-only)
  "Return an appropriate reference for DATUM.
DATUM is an element or a `target' type object.  INFO is the
current export state, as a plist.
When NAMED-ONLY is non-nil and DATUM has no NAME keyword, return
nil.  This doesn't apply to headlines, inline tasks, radio
targets and targets."
  (let* ((type (org-element-type datum))
	 (user-label
	  (org-element-property
	   (pcase type
	     ((or `headline `inlinetask) :CUSTOM_ID)
	     ((or `radio-target `target) :value)
	     (_ :name))
	   datum))
         (user-label (or user-label
                         (when-let ((path (org-element-property :ID datum)))
                           (concat "ID-" path)))))
    (cond
     ((and user-label
	   (or (plist-get info :html-prefer-user-labels)
	       ;; Used CUSTOM_ID property unconditionally.
	       (memq type '(headline inlinetask))))
      user-label)
     ((and named-only
	   (not (memq type '(headline inlinetask radio-target target)))
	   (not user-label))
      nil)
     (t
      (org-export-get-reference datum info)))))


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
	     :with-title nil
	     )))

(setq org-export-with-broken-links 'mark)
(org-publish-all t)

(message "Built website")
