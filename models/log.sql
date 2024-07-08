SELECT MAX(etl_date)
FROM etl_log
WHERE 
    step = :step_name and
    table_name ilike :table_name and
    status = :status and
    process = :process