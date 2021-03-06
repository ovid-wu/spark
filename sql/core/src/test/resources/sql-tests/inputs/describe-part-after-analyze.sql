CREATE TABLE t (key STRING, value STRING, ds STRING, hr INT) USING parquet
    PARTITIONED BY (ds, hr);

INSERT INTO TABLE t PARTITION (ds='2017-08-01', hr=10)
VALUES ('k1', 100), ('k2', 200), ('k3', 300);

INSERT INTO TABLE t PARTITION (ds='2017-08-01', hr=11)
VALUES ('k1', 101), ('k2', 201), ('k3', 301), ('k4', 401);

INSERT INTO TABLE t PARTITION (ds='2017-09-01', hr=5)
VALUES ('k1', 102), ('k2', 202);

DESC EXTENDED t PARTITION (ds='2017-08-01', hr=10);

-- Collect stats for a single partition
ANALYZE TABLE t PARTITION (ds='2017-08-01', hr=10) COMPUTE STATISTICS;

DESC EXTENDED t PARTITION (ds='2017-08-01', hr=10);

-- Collect stats for 2 partitions
ANALYZE TABLE t PARTITION (ds='2017-08-01') COMPUTE STATISTICS;

DESC EXTENDED t PARTITION (ds='2017-08-01', hr=10);
DESC EXTENDED t PARTITION (ds='2017-08-01', hr=11);

-- Collect stats for all partitions
ANALYZE TABLE t PARTITION (ds, hr) COMPUTE STATISTICS;

DESC EXTENDED t PARTITION (ds='2017-08-01', hr=10);
DESC EXTENDED t PARTITION (ds='2017-08-01', hr=11);
DESC EXTENDED t PARTITION (ds='2017-09-01', hr=5);

-- DROP TEST TABLES/VIEWS
DROP TABLE t;
