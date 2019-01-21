view: ratings {
#   sql_table_name: movies_data.ratings ;;

  derived_table: {
    sql:
    SELECT
      ROW_NUMBER() OVER () AS id,
      b.tmdbId AS movieId,
      a.rating,
      TIMESTAMP_SECONDS(a.timestamp) AS timestamp,
      a.userId
    FROM movies_data.ratings AS a
    JOIN movies_data.links AS b
      ON a.movieId = b.movieId
    ;;
  }

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: movie_id {
    type: number
    sql: ${TABLE}.movieId ;;
  }

  dimension: rating {
    type: number
    sql: ${TABLE}.rating ;;
  }

  dimension: timestamp {
    type: date_time
    sql: ${TABLE}.timestamp ;;
  }

  dimension: rating_year {
    type: number
    sql: EXTRACT(YEAR FROM ${TABLE}.timestamp) ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.userId ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
