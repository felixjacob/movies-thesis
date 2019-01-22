view: ratings_summary {
  derived_table: {
    datagroup_trigger: movies_thesis_default_datagroup
    explore_source: ratings {
      column: movie_id {}
      column: rating {}
      column: rating_count {field: ratings.count}
      column: rating_year {}
      derived_column: id {
        sql: ROW_NUMBER() OVER () ;;
      }
      derived_column: total_ratings {
        sql: SUM(rating_count) OVER (PARTITION BY movie_id) ;;
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

  dimension: rating_year {
    type: number
  }

  dimension: total_ratings {
    type: number
  }

  measure: rating_count {
    type: sum
    sql: ${TABLE}.rating_count ;;
    # filters: {
    #   field: actors.role_type
    #   value: "Main"
    # }
  }

  measure: rating_sumproduct{
    type: sum
    sql: ${TABLE}.rating * ${TABLE}.rating_count ;;
    # filters: {
    #   field: actors.role_type
    #   value: "Main"
    # }
  }

  measure: average_rating {
    type: number
    value_format_name: decimal_1
#     sql: SUM(${TABLE}.rating * ${TABLE}.rating_count) / SUM(${TABLE}.rating_count) ;;
    sql: ${rating_sumproduct} / NULLIF(${rating_count}, 0) ;;
    drill_fields: [drill*]
  }

  set: drill {
    fields: [
      movies.release_year,
      movies.title,
      movies.poster,
      actors.character_name,
      # actors.role_type,
      movies.overview,
      genres.all_genres,
      average_rating
    ]
  }

  set: ratings {
    fields:
    [
      rating,
      rating_year,
      total_ratings,
      rating_count,
      average_rating
    ]
  }
}
