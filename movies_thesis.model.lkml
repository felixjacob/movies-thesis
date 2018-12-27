connection: "thesis_bq"

# include all the views
include: "*.view"

datagroup: movies_thesis_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "24 hour"
}

persist_with: movies_thesis_default_datagroup

explore: credits {}

explore: cast {}

explore: crew {}

explore: keywords {}

explore: links {}

explore: movies_metadata {}

explore: ratings {}
