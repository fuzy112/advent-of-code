;; -*- lexical-binding: t; -*-

;;;; part 1
(with-temp-buffer
  (insert-file-contents "day-4.in")
  (let* ((lines (string-lines (buffer-string)))
	 (rows (length lines))
	 (columns (length (car lines)))
	 (count 0))
    (dotimes (i rows)
      (dotimes (j columns)
	(cl-labels ((expect-char-at (y x c)
		      (= c (elt (elt lines (+ i y)) (+ j x)))))
	  (when (expect-char-at 0 0 ?X)
	    ;; up
	    (and (>= i 3)
		 (expect-char-at -1 0 ?M)
		 (expect-char-at -2 0 ?A)
		 (expect-char-at -3 0 ?S)
		 (cl-incf count))
	    ;; down
	    (and (< (+ i 3) rows)
		 (expect-char-at 1 0 ?M)
		 (expect-char-at 2 0 ?A)
		 (expect-char-at 3 0 ?S)
		 (cl-incf count))
	    ;; left
	    (and (>= j 3)
		 (expect-char-at 0 -1 ?M)
		 (expect-char-at 0 -2 ?A)
		 (expect-char-at 0 -3 ?S)
		 (cl-incf count))
	    ;; right
	    (and (< (+ j 3) columns)
		 (expect-char-at 0 1 ?M)
		 (expect-char-at 0 2 ?A)
		 (expect-char-at 0 3 ?S)
		 (cl-incf count))
	    ;; up-left
	    (and (>= i 3)
		 (>= j 3)
		 (expect-char-at -1 -1 ?M)
		 (expect-char-at -2 -2 ?A)
		 (expect-char-at -3 -3 ?S)
		 (cl-incf count))
	    ;; up-right
	    (and (>= i 3)
		 (< (+ j 3) columns)
		 (expect-char-at -1 1 ?M)
		 (expect-char-at -2 2 ?A)
		 (expect-char-at -3 3 ?S)
		 (cl-incf count))
	    ;; down-left
	    (and (< (+ i 3) rows)
		 (>= j 3)
		 (expect-char-at 1 -1 ?M)
		 (expect-char-at 2 -2 ?A)
		 (expect-char-at 3 -3 ?S)
		 (cl-incf count))
	    ;; down-right
	    (and (< (+ i 3) rows)
		 (< (+ j 3) columns)
		 (expect-char-at 1 1 ?M)
		 (expect-char-at 2 2 ?A)
		 (expect-char-at 3 3 ?S)
		 (cl-incf count))))))
    count))

;;;; part 2
(with-temp-buffer
  (insert-file-contents "day-4.in")
  (let* ((lines (string-lines (buffer-string)))
	 (rows (length lines))
	 (columns (length (car lines)))
	 (count 0))
    (cl-loop for i from 1 below (1- rows) do
	     (cl-loop for j from 1 below (1- columns) do
		      (cl-labels ((expect-char-at (y x c)
				    (= c (elt (elt lines (+ i y)) (+ j x)))))
			(and (expect-char-at 0 0 ?A)
			     (or (and (expect-char-at 1 1 ?M) (expect-char-at -1 -1 ?S))
				 (and (expect-char-at 1 1 ?S) (expect-char-at -1 -1 ?M)))
			     (or (and (expect-char-at -1 1 ?M) (expect-char-at 1 -1 ?S))
				 (and (expect-char-at -1 1 ?S) (expect-char-at 1 -1 ?M)))
			     (cl-incf count)))))
    count))
