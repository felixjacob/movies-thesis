view: ratings {
  sql_table_name: movies_data.ratings ;;

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
