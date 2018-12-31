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

explore: movies {
  join: genres {
    sql_on: ${movies.movie_id} = ${genres.movie_id} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: cast {
    sql_on: ${movies.movie_id} = ${cast.movie_id} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: crew {
    sql_on: ${movies.movie_id} = ${crew.movie_id} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: keywords {
    sql_on: ${movies.movie_id} = ${keywords.movie_id} ;;
    type: left_outer
    relationship: one_to_many
  }
}

explore: ratings {}
