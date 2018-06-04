;;; prettify-url-mode.el --- redisplay URLs in pretty format  -*- lexical-binding: t; -*-

;; Copyright (C) 2018  Paul W. Rankin

;; Author: Paul W. Rankin <hello@paulwrankin.com>
;; Keywords: wp

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:


;;; Variables

(defvar prettify-url-regexp
  "https?://\\([^\s\n/]+?\\)/[^\s\n]*")


;;; Customization

(defcustom prettify-url-lighter
  " Purl"
  "Mode-line indicator for `prettify-url-mode'."
  :group 'prettify-url-mode
  :safe 'stringp
  :type 'string)

(defcustom prettify-url-format
  "[%s]"
  "Format for redisplaying URLs."
  :group 'prettify-url-mode
  :safe 'stringp
  :type string)


;;; Functions

(defun prettify-url-redisplay (start end)
  (goto-char start)
  (while (re-search-forward prettify-url-regexp end t)
    (setq string (format prettify-url-format (match-string-no-properties 1)))
    (put-text-property (match-beginning 0) (match-end 0) 'display
                       string)))


;;; Mode Definition

;;;###autoload
(define-minor-mode prettify-url-mode
  "Redisplay date and time strings in pretty format."
  :init-value nil
  :lighter prettify-url-lighter
  (if prettify-url-mode
      (jit-lock-register #'prettify-url-redisplay)
    (jit-lock-unregister #'prettify-url-redisplay)
    (with-silent-modifications
     (set-text-properties (point-min) (point-max) 'dislay))))

(provide 'prettify-url-mode)
;;; prettify-url-mode.el ends here
