# Week 3 and Week 4

## Data Ingestion (Week 3)
Live Class:
- Data Extraction
- Data Loading

## Data Transformation and Validation (Week 4)
Live Class
- Data Transformation
- Data Validation

## Tools and Technologies:
- Python: For build Data Pipeline
- PostgreSQL: For log, staging and final data storage.
- MinIO: For load failed data.
- Docker: For running MinIO

## Preparation
1. Dataset
    1. Restore Database Dell DVD Store (./data/dellstore.sql)
    2. Dupplicate Spreadsheet [Link](https://docs.google.com/spreadsheets/d/1qEekzxEExv_PZpT3LFg5HPllCH2OiKX1wwESJmlAZV0/edit?usp=sharing)
    3. Check Data API [Link](https://api-history-order.vercel.app/api/dummydata?start_date=2004-01-01&end_date=2004-01-01)
2. Database
   1. Create Staging Database (./data/staging_schema.sql)
   2. Create Warehouse Database (./data/warehouse_schema.sql)
   3. Create Log Database (./data/etl_log.sql)
3. Porject
   1. Save Your Credential Google Service Account
   2. Prepare Your MiniO (Access Key, Secreet Key, Bucket Name: "error-dellstore")
   4. create your .env

      ```
      DB_HOST="localhost"
      DB_USER="YOUR POSTGRES USER"
      DB_PASS="YOUR POSGRES PASS"

      DB_NAME_SOURCE="dellstore"
      DB_NAME_STG="staging"
      DB_SHCHEMA_STG="staging"
      DB_NAME_log="etl_log"
      DB_NAME_DW="warehouse_dellstore"

      CRED_PATH='YOUR_PATH/creds/file.json'
      MODEL_PATH='YOUR_PATH/models/'
      KEY_SPREADSHEET="YOUR SPREADSHEET KEY"

      ACCESS_KEY_MINIO = 'YOUR MINIO ACCESS KEY'
      SECRET_KEY_MINIO = 'YOUR MINIO SECRET KEY'

      ```

