# import thư viện cần thiết

from pyspark.sql import SparkSession
from pyspark.sql.functions import col, isnan, when, count
import pandas as pd
import matplotlib.pyplot as pyplot
from pyspark.ml.feature import VectorAssembler
from pyspark.ml.feature import StandardScaler
from pyspark.ml.clustering import KMeans
from pyspark.ml.evaluation import ClusteringEvaluator

spark = SparkSession.builder.appName("K-means Clustering").master("spark://thaihoc02-ictu:7077").getOrCreate()

customer_df = spark.read.options(header=True, inferSchema=True).csv("customer-rfm-origin.csv")

print("------------Hiển thị tập dữ liệu---------------------------")
customer_df.show(5)

print("-----------------Kiểm tra kiểu dữ liệu của các cột---------")
customer_df.printSchema()

print("-----------------Thống kê mô tả tập dữ liệu----------------")
customer_df.describe().show()

print("---------------Kiểm tra các giá trị bị thiếu-----------------")
customer_df.select([count(when(isnan(CustomerID) | col(CustomerID).isNull(), CustomerID)).alias(CustomerID) for CustomerID in customer_df.columns]).show()

# xóa các dòng dữ liệu bị thiếu CustomerID
a = customer_df.dropna(subset=["CustomerID"])


a = spark.read.options(header=True, inferSchema=True).csv("rfm.csv")

# đổi tên cột dữ liệu
final_df = a.withColumnRenamed("InvoiceDate", "Recency").withColumnRenamed("InvoiceNo", "Frequency").withColumnRenamed("TotalPay", "Monetary")

print("------------Hiện thị tập dữ liệu sau khi tính toán chỉ số RFM------")
final_df.show(5)

col_number = final_df.columns

# chuyển dữ liệu cột thành VectorAssembler

print("-------------Dữ liệu sau khi được chuyển thành vector-----------------")
num_vector = VectorAssembler(inputCols=col_number,
                             outputCol="num_vector")

train = num_vector.transform(final_df)
train.show(5)

# co giãn đặc trưng
print("--------------Dữ liệu sau khi được co giãn đặc trưng-------------------")
scaler = StandardScaler(inputCol="num_vector",
                        outputCol="scaler_number",
                        withMean=True, withStd=True)

scaler = scaler.fit(train)

train = scaler.transform(train)

train.show(5)

# tính điểm silhouette cho các cụm được khởi tạo ngẫu nhiên
silhouette_score = []
evaluator = ClusteringEvaluator(predictionCol='prediction',
                                featuresCol="scaler_number",
                                metricName="silhouette",
                                distanceMeasure="squaredEuclidean")

print("------------------Tính điểm silhouette cho số cụm ngẫu nhiên----------")
for i in range(2, 10):
  kmeans = KMeans(featuresCol="scaler_number", k=i, seed=42)
  model = kmeans.fit(train)
  preditions = model.transform(train)
  score=evaluator.evaluate(preditions)
  silhouette_score.append(score)
  print("Sil score for k = ", i, "is", score)

# huấn luyện mô hình với k=3
kmeans = KMeans(featuresCol="scaler_number", k=3, seed=42)
model = kmeans.fit(train)
predictions = model.transform(train)

# hiển thị tập dữ liệu với các nhãn là các cụm được mô hình dự đoán
a = predictions.select("Recency").rdd.flatMap(lambda x: x).collect()
b = predictions.select("Frequency").rdd.flatMap(lambda x: x).collect()
c = predictions.select("Monetary").rdd.flatMap(lambda x: x).collect()
d = predictions.select("prediction").rdd.flatMap(lambda x: x).collect()

results_df = pd.DataFrame({
    "Recency" : a,
    "Frequency": b,
    "Monetary" : c,
    "Cluster" : d
})

results = spark.createDataFrame(results_df)
results.show(5)








































































