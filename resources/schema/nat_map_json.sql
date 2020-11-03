DROP TABLE IF EXISTS nat_map_json;
CREATE TABLE nat_map_json (
   code         VARCHAR(10)  PRIMARY KEY 
  ,name                VARCHAR(60)
  ,value               FLOAT
);