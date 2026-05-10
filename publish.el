;;; publish.el --- Generate Weblorg page
;;; Commentary:
;;
;; Generate static website for weblorg
;;
;;; Code:
;;

;; Setup package management
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(unless package-archive-contents
  (package-refresh-contents))

;; Install and configure dependencies
(use-package templatel :ensure t)
(use-package htmlize  :ensure t)
(use-package weblorg  :ensure t)

;; Defaults to localhost:8000
(if (string= (getenv "ENV") "prod")
    (setq weblorg-default-url "https://emacs.love/tales"))

;; Generate index
(weblorg-route
 :name "index"
 :input-pattern "tales/*.org"
 :input-aggregate #'weblorg-input-aggregate-all-desc
 :template "index.html"
 :output "index.html"
 :url "/")

(weblorg-route
 :name "tale"
 :input-pattern "tales/*.org"
 :template "tale.html"
 :output "{{ slug }}.html"
 :url "/{{ slug }}.html")

(weblorg-route
 :name "static"
 :url "/static/{{ file }}")

(weblorg-export)
;;; publish.el ends here
