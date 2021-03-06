;;;(((((((((((((((((((((((((((((((( L i S P ))))))))))))))))))))))))))))))))
;;; This file is derived from the files that accompany the book:
;;;     LISP Implantation Semantique Programmation (InterEditions, France)
;;;     or  Lisp In Small Pieces (Cambridge University Press).
;;; By Christian Queinnec <Christian.Queinnec@INRIA.fr>
;;; The original sources can be downloaded from the author's website at
;;;   http://pagesperso-systeme.lip6.fr/Christian.Queinnec/WWW/LiSP.html
;;; This file may have been altered from the original in order to work with
;;; modern schemes. The latest copy of these altered sources can be found at
;;;   https://github.com/appleby/Lisp-In-Small-Pieces
;;; If you want to report a bug in this program, open a GitHub Issue at the
;;; repo mentioned above.
;;; Check the README file before using this file.
;;;(((((((((((((((((((((((((((((((( L i S P ))))))))))))))))))))))))))))))))

;;; This file defines some functions that should be included in programs
;;; compiled with the interpreter of the book.

;;; See mit-scheme/mit-book.scm for a fully-commented version of this
;;; file that can be used as a template for ports to other scheme's.

(module rtbook
        (eval (export-all))
        ;; Time utility
        (foreign (int time (string) "time"))
        ;; Meroonet (preceded by a small hack that also defines the
        ;; define-abbreviation macro)
        (include "bigloo/hack.scm")
	(include "common/compat/load-relative.scm")
        (include "meroonet/meroonet.scm")
        ;; Additional utilities
        (include "src/tester.scm")
        (include "common/pp.scm")
        (include "common/format.scm")
        (include "common/definitions.scm")
        (include "common/generics.scm")
        (include "common/toplevel.scm")
        ;; Exported from this file
        (export meroonet-error
                tester-error
                (test file)
                the-Point
                display-exception
                wrong
                static-wrong
                (list* . args)
                (get-internal-run-time)
                internal-time-units-per-second
                (atom? x)
                (iota start end)
                putprop
                (start) )
        ;; From format.scm and pp.scm, do not export pp that already exists in
        ;; Bigloo.
        (export (format destination control-string . args))
        ;; Exported from tester.scm
        (export (interpreter a b c d)
                (suite-test a b c d e f) )
        ;; Exported from Meroonet
        (export (number->class n)
                (->Class name)
                (->Generic name)
                *last-defined-class*
                (object->class o)
                (Object? o)
                (symbol-concatenate . names)
                Object-class
                Class-class
                Generic-class
                Field-class
                Mono-Field-class
                Poly-Field-class
                (make-predicate class)
                (is-a? o class)
                (check-class-membership o class)
                (make-allocator class)
                (make-maker class)
                (retrieve-named-field class name)
                (make-reader field)
                (field-value o field . i)
                (make-writer field)
                (set-field-value! o v field . i)
                (make-lengther field)
                (field-length o field)
                (register-class name super-name own-field-descriptions)
                (Class-initialize! class name super own-field-descriptions)
                (Field-defining-class field)
                Class?
                Generic?
                Field?
                Mono-Field?
                Poly-Field?
                Class-name
                set-Class-name!
                Class-number
                set-Class-number!
                Class-fields
                set-Class-fields!
                Class-superclass
                set-Class-superclass!
                Class-subclass-numbers
                set-Class-subclass-numbers!
                make-Class
                allocate-Class
                make-Generic
                allocate-Generic
                Generic-name
                set-Generic-name!
                Generic-default
                set-Generic-default!
                Generic-dispatch-table
                set-Generic-dispatch-table!
                Generic-signature
                set-Generic-signature!
                Field-name
                set-Field-name!
                Field-defining-class-number
                set-Field-defining-class-number!
                make-Mono-Field
                allocate-Mono-Field
                make-Poly-Field
                allocate-Poly-Field
                (register-generic generic-name default signature)
                (register-method generic-name pre-method class-name signature)
                (determine-method generic o) )
        )

;(display "[rtbook.scm...")(newline) ; DEBUG

;;; Include an eval so exported global variables can also appear as symbols.
(eval ''hack)

(define book-interpreter-support 'bigloo)

(define book-interpreter-name "Bigloo")

(define (get-internal-run-time)
  (let ((t (make-string 4)))
    (time t) ) )

(define internal-time-units-per-second 1)

(define putprop putprop!)

(define flush-buffer flush-output-port)

(define display-exception display)

(define (make-toplevel read print-or-check err)
  (set! tester-error   err)
  (set! meroonet-error err)
  (lambda ()
    (try (print-or-check (eval (read)))
         (lambda (k a b c) (err a b c)) ) ) )

;(display " ...")(newline) ; DEBUG
;(display "]")(newline) ; DEBUG

;;; end of rtbook.scm
