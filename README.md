# abcl-spark
### _Alejandro Zamora <ale2014.zamora@gmail.com>_

A micro router : Simple wrapper for the Sparkjava web framework with ABCL Common Lisp

Not intended to cover all the details of the framework but maybe it can be useful for someone else

Anyway, I think, you can play with the 'request' and 'response' arguments in your route's functions and do more complex things
following Sparkjava docs with ABCL

Quickstart

```
CL-USER> (require :abcl-asdf)
("ABCL-ASDF")
CL-USER> (require :abcl-contrib)
NIL
CL-USER> (asdf:load-system :quicklisp-abcl)
T
CL-USER> (ql:quickload :abcl-spark)
(:ABCL-SPARK)
CL-USER> (spark:start-server 8080)
NIL
CL-USER> (spark:add-endpoint-handler "/hello/:name" :get
           (lambda (req res)
             (let ((get-dict-method (java:jmethod "java.util.Collections$UnmodifiableMap" "get" "java.lang.Object"))
                   (params (java:jcall (jmethod "spark.Request" "params") req)))
               (format nil "Hello, ~a!" (java:jcall get-dict-method params ":name")))))
NIL
CL-USER> (spark:add-endpoint-handler "/hello" :get
           (lambda (req res)
             "Hello, world!"))
NIL
CL-USER> (spark:add-endpoint-handler "/hello" :post
           (lambda (req res)
             "Hello, world!"))
NIL
CL-USER> (ql:quickload :drakma)
;; ...
(:DRAKMA)
CL-USER> (drakma:http-request "http://localhost:8080/hello" :method :post)
"Hello, world!"
200 (8 bits, #xC8, #o310, #b11001000)
((:DATE . "Wed, 29 Jun 2022 03:48:37 GMT")
 (:CONTENT-TYPE . "text/html;charset=utf-8") (:CONNECTION . "close")
 (:SERVER . "Jetty(9.3.6.v20151106)"))
#<PURI:URI http://localhost:8080/hello>
#<FLEXI-STREAMS:FLEXI-IO-STREAM {4720520F}>
T
"OK"
CL-USER> (drakma:http-request "http://localhost:8080/hello" :method :get)
"Hello, world!"
200 (8 bits, #xC8, #o310, #b11001000)
((:DATE . "Wed, 29 Jun 2022 03:48:52 GMT")
 (:CONTENT-TYPE . "text/html;charset=utf-8") (:CONNECTION . "close")
 (:SERVER . "Jetty(9.3.6.v20151106)"))
#<PURI:URI http://localhost:8080/hello>
#<FLEXI-STREAMS:FLEXI-IO-STREAM {274B9EF3}>
T
"OK"
CL-USER> (drakma:http-request "http://localhost:8080/hello/alex" :method :get)
"Hello, alex!"
200 (8 bits, #xC8, #o310, #b11001000)
((:DATE . "Wed, 29 Jun 2022 03:48:59 GMT")
 (:CONTENT-TYPE . "text/html;charset=utf-8") (:CONNECTION . "close")
 (:SERVER . "Jetty(9.3.6.v20151106)"))
#<PURI:URI http://localhost:8080/hello/alex>
#<FLEXI-STREAMS:FLEXI-IO-STREAM {23D32821}>
T
"OK"
CL-USER> (spark:stop-server)
NIL
CL-USER>
```


## License

MIT
