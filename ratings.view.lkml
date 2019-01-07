view: ratings {
#   sql_table_name: movies_data.ratings ;;

  derived_table: {
    sql:
    SELECT
      ROW_NUMBER() OVER () AS id,
      *
    FROM movies_data.ratings
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
    type: number
    sql: ${TABLE}.timestamp ;;
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
