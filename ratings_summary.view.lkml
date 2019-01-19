view: ratings_summary {
  derived_table: {
    datagroup_trigger: movies_thesis_default_datagroup
    explore_source: ratings {
      column: movie_id {}
      column: rating {}
      column: rating_count {field: ratings.count}
      derived_column: id {
        sql: ROW_NUMBER() OVER () ;;
      }
    }
  }

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: movie_id {
    type: number
  }

  dimension: rating {
    type: number
  }

  measure: rating_count {
    type: sum
    sql: ${TABLE}.rating_count ;;
  }

  measure: average_rating {
    type: number
    sql: SUM(${TABLE}.rating * ${TABLE}.rating_count) / ${rating_count} ;;
  }

  set: ratings {
    fields: [rating, rating_count, average_rating]
  }
}
