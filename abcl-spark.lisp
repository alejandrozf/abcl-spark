;;;; abcl-spark.lisp

(in-package #:abcl-spark)

(defmacro add-endpoint-handler (route http-verb function)
  `(java:jstatic (java:jmethod "spark.Spark" ,http-verb "java.lang.String" "spark.Route")
                 "spark.Spark" ,route (java:jinterface-implementation "spark.Route"
                                                                      "handle" ,function)))

(let ((init-method (java:jmethod "spark.Spark" "init"))
      (stop-method (java:jmethod "spark.Spark" "stop"))
      (set-port-method (java:jmethod "spark.Spark" "port" "int")))

  (defun start-server (&optional (port 4567))
    (java:jstatic set-port-method "spark.Spark" port)
    (java:jstatic init-method "spark.Spark"))

  (defun stop-server ()
    (java:jstatic stop-method "spark.Spark"))

  (defun restart-server ()
    (stop-server)
    (start-server)))
