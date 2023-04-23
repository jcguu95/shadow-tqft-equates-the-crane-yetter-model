(declaim (optimize (safety 3) (debug 3)))

(defparameter *source-dir*
  "/Users/jin/.+PLUGS/storage-local/academics/research/shadow-tqft-equates-the-crane-yetter-model/lisp")

(defparameter *latex-content*
  (i (#\Newline) *header* *body*))

(unless (probe-file *source-dir*)
  (error "Source dir not found!"))

(defun write-and-compile ()
  (format t "Side effect! Writing and compiling!~%")
  (alexandria:write-string-into-file *latex-content*
                                     (format nil "~a/build/out-with-lisp.tex" *source-dir*)
                                     :if-exists :supersede)
  (handler-case
      (uiop:run-program (format nil "
cd ~a/build/;
pwd;
pdflatex -halt-on-error -output-directory ~a/build out-with-lisp.tex;
biber out-with-lisp;
pdflatex -halt-on-error -output-directory ~a/build out-with-lisp.tex;
rm -f ./out-with-lisp.{ps,log,aux,out,dvi,bbl,blg,bcf,xml,run.xml,toc};
rm -f texput.log;"
                                *source-dir*
                                *source-dir*
                                *source-dir*)
                        :output t
                        :error-output t)
    (sb-int:stream-decoding-error (c)
      (format t "~%Encounter but skip condition: ~s~%" c)) ; TODO Handle this case properly.
    ))
;; Side-effects
;;
(write-and-compile)
