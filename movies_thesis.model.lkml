connection: "thesis_bq"

# include all the views
include: "*.view"

datagroup: movies_thesis_default_datagroup {
  sql_trigger: SELECT MAX(id) FROM movies_data.movies_metadata;;
  max_cache_age: "24 hour"
}

persist_with: movies_thesis_default_datagroup

explore: cast {}

explore: crew {}

explore: genres {}

explore: keywords {}

explore: links {}

explore: movies_metadata {}

explore: ratings {}
