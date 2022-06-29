;;;; abcl-spark.asd

(asdf:defsystem #:abcl-spark
  :description "Describe abcl-spark here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :components ((:mvn "com.sparkjava/spark-core/2.5")
               (:file "package")
               (:file "abcl-spark")))
