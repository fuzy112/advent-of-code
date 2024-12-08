;; -*- lexical-binding: t; -*-

;;;; part 1
(with-temp-buffer
  (insert-file-contents "day-3.in")
  (goto-char (point-min))
  (let ((sum 0))
    (while (re-search-forward "mul(\\([[:digit:]]+\\),\\([[:digit:]]+\\))" nil t)
      (let ((x (string-to-number (match-string 1)))
	    (y (string-to-number (match-string 2))))
	(setq sum (+ sum (* x y)))))
    sum))

;;;; part-2
(with-temp-buffer
  (insert-file-contents "day-3.in")
  (goto-char (point-min))
  (let ((sum 0)
	(enabled t))
    (while (re-search-forward "do()\\|don't()\\|mul(\\([[:digit:]]+\\),\\([[:digit:]]+\\))" nil t)
      (pcase (match-string 0)
	("do()"
	 (setq enabled t))
	("don't()"
	 (setq enabled nil))
	(_
	 (when enabled
	   (let ((x (string-to-number (match-string 1)))
		 (y (string-to-number (match-string 2))))
	     (setq sum (+ sum (* x y))))))))
    sum))
