view: credits {
  sql_table_name: movies_data.credits ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: cast {
    type: string
    sql: ${TABLE}.``cast`` ;;
  }

  dimension: crew {
    type: string
    sql: ${TABLE}.crew ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
