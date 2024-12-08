;; -*- lexical-binding: t; -*-

;;;; part 1
(with-temp-buffer
  (insert-file-contents "day-2.in")
  (let* ((inputs (mapcar (lambda (line)
			  (mapcar #'string-to-number
				  (string-split line)))
			(string-lines (buffer-substring-no-properties
				       (point-min) (point-max))))))
    (seq-count (lambda (lst)
		 (let ((diffs (seq-mapn #'- lst (cdr lst))))
		   (seq-every-p (let ((positive (> (car diffs) 0)))
				  (lambda (x)
				    (and (/= x 0)
					 (<= (abs x) 3)
					 (eq (> x 0) positive))))
				diffs)))
	       inputs)))

;;;; part 2
(with-temp-buffer
  (insert-file-contents "day-2.in")
  (let* ((inputs (mapcar (lambda (line)
			   (mapcar #'string-to-number
				   (string-split line)))
			 (string-lines (buffer-substring-no-properties
					(point-min) (point-max))))))
    (cl-labels ((strictly-safe-p (lst)
		 (let ((diffs (seq-mapn #'- lst (cdr lst))))
		   (seq-every-p (let ((positive (> (car diffs) 0)))
				  (lambda (x)
				    (and (/= x 0)
					 (<= (abs x) 3)
					 (eq (> x 0) positive))))
				diffs)))
		(safe-p (lst)
		  (seq-some #'strictly-safe-p
				(seq-map (lambda (n)
					   (append (take n lst)
						   (drop (1+ n) lst)))
					 (number-sequence 0 (length lst))))))
      (seq-count #'safe-p inputs))))
