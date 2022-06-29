;;;; abcl-spark.lisp

(in-package #:abcl-spark)

(defparameter *routes-methods* (make-hash-table))

(defun add-route-method (http-verb)
  (java:jmethod "spark.Spark" http-verb "java.lang.String" "spark.Route"))

(loop :for http-verb :in '(:get :post :put :delete :options)
      :do (setf (gethash http-verb *routes-methods*)
                (add-route-method (string-downcase (symbol-name http-verb)))))


(let ((init-method (java:jmethod "spark.Spark" "init"))
      (stop-method (java:jmethod "spark.Spark" "stop"))
      (set-port-method (java:jmethod "spark.Spark" "port" "int"))
      (unmap-method (java:jmethod "spark.Spark" "unmap" "java.lang.String")))

  (defun add-endpoint-handler (route http-verb function)
    (java:jstatic unmap-method "spark.Spark" route)
    (java:jstatic (gethash http-verb *routes-methods*)
                  "spark.Spark" route
                  (java:jinterface-implementation "spark.Route"
                                                  "handle" function)))

  (defun start-server (&optional (port 4567))
    (java:jstatic set-port-method "spark.Spark" port)
    (java:jstatic init-method "spark.Spark"))

  (defun stop-server ()
    (java:jstatic stop-method "spark.Spark"))

  (defun restart-server ()
    (stop-server)
    (start-server)))
