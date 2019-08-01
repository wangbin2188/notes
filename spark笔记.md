用户维度-1

```shell
spark-submit --deploy-mode cluster --conf spark.executor.extraJavaOptions=-XX:+UseConcMarkSweepGC --conf spark.default.parallelism=400 --conf spark.sql.shuffle.partitions=2000 --num-executors 80 --executor-memory 4g --files s3://migration-pengxiao-test/spark/wangbin/pnos.txt --class UserTraceToDynamoDB s3://jiayun-search-code/realtime-usertrace/dev/realtime-usertrace-1.3-jar-with-dependencies.jar realtime-usertrace-test 20 10 1000 10000
```



商品维度

```shell
spark-submit --deploy-mode cluster --conf spark.executor.extraJavaOptions=-XX:+UseConcMarkSweepGC --conf spark.default.parallelism=400 --conf spark.sql.shuffle.partitions=2000 --num-executors 40 --executor-memory 4g --class UserTraceToDynamoDB s3://jiayun-search-code/realtime-usertrace-product/dev/realtime-usertrace-product-jar-with-dependencies.jar realtime-usertrace-product19 20 10 1000 60000
```



用户维度-2

```shell
spark-submit --deploy-mode cluster --conf spark.executor.extraJavaOptions=-XX:+UseConcMarkSweepGC --conf spark.default.parallelism=400 --conf spark.sql.shuffle.partitions=2000 --num-executors 80 --executor-memory 4g --class UserTraceToMysql s3://jiayun-search-code/realtime-usertrace-user/dev/realtime-usertrace-user-jar-with-dependencies.jar realtime-usertrace-user14 20 10 1000 10000
```



