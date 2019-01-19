view: links {
  sql_table_name: movies_data.links ;;

  dimension: imdb_id {
    hidden: yes
    type: number
    sql: ${TABLE}.imdbId ;;
  }

  dimension: movie_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.movieId ;;
  }

  dimension: tmdb_id {
    hidden: yes
    type: number
    sql: ${TABLE}.tmdbId ;;
  }
}
