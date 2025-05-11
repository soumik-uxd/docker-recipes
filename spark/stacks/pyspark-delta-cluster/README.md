```bash
spark-submit --packages io.delta:delta-spark_2.12:3.3.0 \
    --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" \
    --conf "spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog" \
    --jars  "/opt/spark/jars/delta-core_3.5.5-2.4.0.jar,/opt/spark/jars/delta-spark_3.5.5-3.3.0.jar,/opt/spark/jars/delta-storage-3.3.0.jar" \
    scripts/delta-demo.py
```
