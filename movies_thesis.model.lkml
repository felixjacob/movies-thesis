connection: "thesis_bq"

# include all them views
include: "*.view"

datagroup: movies_thesis_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: movies_thesis_default_datagroup

explore: credits {}

explore: keywords {}

explore: links {}

explore: movies_metadata {}

explore: ratings {}
