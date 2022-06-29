;;;; abcl-spark.asd

(asdf:defsystem #:abcl-spark
  :description "Micro web router"
  :author "Alejandro Zamora <ale2014.zamora@gmail.com>"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :components ((:mvn "com.sparkjava/spark-core/2.9.3")
               (:file "package")
               (:file "abcl-spark")))
