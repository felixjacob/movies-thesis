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

  measure: rating_sumproduct{
    type: sum
    sql: ${TABLE}.rating * ${TABLE}.rating_count ;;
  }

  measure: average_rating {
    type: number
    value_format_name: decimal_1
#     sql: SUM(${TABLE}.rating * ${TABLE}.rating_count) / SUM(${TABLE}.rating_count) ;;
    sql: ${rating_sumproduct} / NULLIF(${rating_count}, 0) ;;
    drill_fields:
    [
      movies.release_year,
      movies.title,
      movies.poster,
      actors.character_name,
      movies.overview,
      average_rating
    ]
  }

  set: ratings {
    fields:
    [
      rating,
      rating_count,
      average_rating
    ]
  }
}
