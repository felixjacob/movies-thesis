view: links {
  sql_table_name: movies_data.links ;;

  dimension: imdb_id {
    type: number
    sql: ${TABLE}.imdbId ;;
  }

  dimension: movie_id {
    type: number
    sql: ${TABLE}.movieId ;;
  }

  dimension: tmdb_id {
    type: number
    sql: ${TABLE}.tmdbId ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
