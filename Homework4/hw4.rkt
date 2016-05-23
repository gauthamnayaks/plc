
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

(define (sequence low high stride)
  (if (> low high)
      null
      (cons low (sequence (+ low stride) high stride))))

(define (string-append-map xs suffix)
  (map (lambda (listx) (append listx (list suffix))) xs))

(define (list-nth-mod xs n)
  (if (< n 0)
     (error "list-nth-mod: negative number")
     (if (null? xs)
         (error "list-nth-mod: empty list")
         (car (list-tail xs (remainder n (length xs)))))))

(define (stream-for-n-steps s n)
  (if (<= n 0)
      null
      (let ([nexts (s)])
            (cons (car nexts) (stream-for-n-steps (cdr nexts) (- n 1))))))

(define funny-number-stream
        (letrec ([f (lambda (x) (cons (if (= (remainder x 5) 0)
                                         (- 0 x)
                                         x)
                                      (lambda () (f (+ x 1)))))])
(lambda () (f 1))))
  
(define dan-than-dog
  (lambda () (cons "dan.jpg"
                   (lambda () (cons "dog.jpg" dan-than-dog)))))

(define (stream-add-zero s)
  (let ([nexts (s)])
    (lambda () (cons (cons 0 (car nexts)) (stream-add-zero (cdr nexts))))))

(define (cycle-lists xs ys)
  (letrec ([f (lambda(n)
                (cons (cons (list-nth-mod xs n) (list-nth-mod ys n))
                      (lambda() (f (+ n 1)))))])
    (lambda () (f 0))))

(define (vector-assoc v vec)
  (letrec ([f (lambda (n)
                (cond [equal? n (vector-length vec) #f]
                      [(pair? (vector-ref vec n)) (if (equal? (car (vector-ref vec n)) v)
                                                      (vector-ref vec n) (f (+ n 1)))]
                      [#t (f (+ n 1))]))])
    (f 0)))