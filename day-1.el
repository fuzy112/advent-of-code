;; -*- lexical-binding: t; -*-

;;;; part 1
(with-temp-buffer
  (insert-file-contents "day-1.in")
  (let* ((inputs (mapcar #'string-to-number
			 (string-split (buffer-substring-no-properties (point-min) (point-max)))))
	 (left (cl-loop for elem in inputs by #'cddr collect elem))
	 (right (cl-loop for elem in (cdr inputs) by #'cddr collect elem)))
    (setq left (sort left #'<))
    (setq right (sort right #'<))
    (seq-reduce (pcase-lambda (acc `(,x . ,y))
		  (+ acc (abs (- x y))))
		(seq-mapn (lambda (x y)
			    (cons x y))
			  left right)
		0)))

;;;; part 2
(with-temp-buffer
  (insert-file-contents "day-1.in")
  (let* ((inputs (mapcar #'string-to-number
			 (string-split (buffer-substring-no-properties (point-min) (point-max)))))
	 (left (cl-loop for elem in inputs by #'cddr collect elem))
	 (right (cl-loop for elem in (cdr inputs) by #'cddr collect elem)))
    (setq left (sort left #'<))
    (setq right (sort right #'<))
    (seq-reduce (lambda (acc x)
		  (+ acc (* x (seq-count (lambda (y) (= x y))
					 right))))
		left
		0)))
