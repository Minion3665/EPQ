(require 'ox-publish)
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("nongnu" . "https://elpa.nongnu.org/nongnu/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)
(setq org-roam-v2-ack t)
(package-install 'org-roam)
(package-install 'org)
(require 'org-roam)

(setq org-roam-directory (file-truename "./Notes"))
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
      "<link rel=\"stylesheet\" href=\"/simple.min.css\" /><link rel=\"stylesheet\" href=\"/custom.css\" />")

(defun org-publish-org-sitemap (title list)
  "Sitemap generation function."
  (concat "
#+TITLE: Home

* Who am I?
Hi! I'm Skyler, a teenaged developer. I work with [[https://clicksminuteper.net][Clicks Minute Per]] to make discord bots & websites for fun, for money and because they're cool. We do development, designing & hosting in-house.

* What is the EPQ?
EPQ stands for /Extended Project Qualification/; it's an independent project worth half an a-level. It helps build skills such as time-management and research.

I'm taking the EPQ because my 6th form requires me to take it, however it also offers benefits in other areas and it can't be said that me taking the EPQ was entirely down to my 6th-form, I did choose to go here after all. The EPQ (as previously mentioned) helps develop various skills, people who've taken an EPQ tend to have higher grades overall and the EPQ also looks great on a personal statement or university application, with some universities even offering lower grade requirements if you get high EPQ grades. All-in-all it's a great opportunity for me.

* What am I doing for EPQ?
For my EPQ, I'm making a process management daemon. I [[file:Documents/process-manager-project-requirements.org][wrote a specification in year 11 for what this could look like]], which is what I'll be following as a rough guide. When the project is finished, I'll be taking it on to our production server and using it to run all of our bots, websites & other projects.

* All pages
"
          (org-list-to-org list)))

(defun sitemap-format-entry-function (entry style project)
  "Format ENTRY in org-publish PROJECT Sitemap format ENTRY ENTRY STYLE format that includes date."
  (let ((filename (org-publish-find-title entry project)))
    (if (= (length filename) 0)
        (format "*%s*" entry)
      (format "[[file:%s][%s]] (Created %s)"
              entry
              filename
	      (format-time-string "on %Y-%m-%d at %H:%M:%S"
                                  (org-publish-find-date entry project))))))

(defun latest-org-file (path)
  (car
 (seq-find
  '(lambda (x) (not (nth 1 x))) ; non-directory
  (sort
   (directory-files-and-attributes path nil ".*\.org$" t)
   '(lambda (x y) (time-less-p (nth 5 y) (nth 5 x))))))) ; last modified first: y < x
;; https://stackoverflow.com/questions/30886282/emacs-lisp-how-can-i-get-the-newest-file-in-a-directory

(setq org-publish-project-alist
      (list
       (list "epq-project-docs"
	     :recursive t
	     :base-directory "./Web"
	     :publishing-directory "./Web-out"
	     :base-extension "org"
	     :publishing-function 'org-html-publish-to-html
	     :with-author nil
	     :with-creator nil
	     :time-stamp-file nil
	     :section-numbers nil
	     :title "Skyler Turner's EPQ"
	     :with-title nil
	     
	     :auto-sitemap t
	     :sitemap-filename "index.org"
	     :sitemap-title "Home"
	     :sitemap-sort-files 'anti-chronologically
	     :sitemap-function 'org-publish-org-sitemap
	     :sitemap-format-entry 'sitemap-format-entry-function

	     :html-preamble (concat "
<div class=\"header\">
    <span class=\"title\">%t</span>
    <div class=\"links\">
        <a href=\"/\">Home</a>
        <a href=\"/Notes/daily/" (replace-regexp-in-string "\.org$" "" (latest-org-file "./Notes/daily")) ".html\">Latest daily</a>
        <a href=\"https://github.com/Minion3665/EPQ/issues/new\">Report issue</a>
        <a href=\"https://github.com/Minion3665/EPQ\">View source</a>
    </div>
</div>")
	     )
       (list "org-static"
	     :base-directory "./Web"
	     :base-extension ".*"
	     :publishing-directory "./Web-out"
	     :recursive t
	     :publishing-function 'org-publish-attachment
	     )))

(setq org-export-with-broken-links 'mark)
(org-publish-all t)

(message "Built website")
