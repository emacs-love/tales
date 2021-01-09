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

;; Install and configure dependencies
(use-package templatel)
(use-package htmlize)
(use-package weblorg)

;; Defaults to localhost:8000
(if (string= (getenv "ENV") "prod")
    (setq weblorg-default-url "https://emacs.love/"))

;; Generate index
(weblorg-route
 :name "index"
 :input-pattern "stories/*.org"
 :input-aggregate #'weblorg-input-aggregate-all
 :template "index.html"
 :output "index.html"
 :url "/")


(weblorg-export)
;;; publish.el ends here
