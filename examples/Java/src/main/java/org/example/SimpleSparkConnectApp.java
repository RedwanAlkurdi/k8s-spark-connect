package org.example;

import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SparkSession;

public class SimpleSparkConnectApp {
    public static void main(String[] args) {
        // Connect to Spark Connect server (adjust host/port if needed)
        SparkSession spark = SparkSession.builder()
                .remote("sc://spark-connect.zerocarbon-1.nzero.net:443/;use_ssl=true")
                .config("spark.app.name", "JavaSparkConnectTest1")
                .getOrCreate();

        spark.conf().set("spark.sql.session.localRelationCacheThreshold", 64 * 1024 * 1024);
        
        // Perform a simple operation
        Dataset<Row> df = spark.range(10).toDF();
        df.show();

        try {
            spark.stop();
            // Add a small delay to give the Spark Connect client's cleanup threads time to complete
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            // Log the exception but don't rethrow since we're already in the shutdown phase
            System.err.println("Interrupted during Spark cleanup: " + e.getMessage());
            // Restore the interrupted status
            Thread.currentThread().interrupt();
        }
    }
}
