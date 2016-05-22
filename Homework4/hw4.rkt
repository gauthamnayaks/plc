
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
  
