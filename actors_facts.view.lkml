view: actors_facts {
  derived_table: {
    explore_source: actors {
      column: actor_id {}
      column: total_movies_count { field: movies.movies_count }
      column: first_movie_year {}
      column: last_movie_year {}
      column: total_main_roles_count { field: actors.main_roles_count }
      column: total_secondary_roles_count { field: actors.secondary_roles_count }
    }
  }

  dimension: actor_id {
    primary_key: yes
    type: number
  }

  dimension: total_movies_count {
    type: number
  }

  dimension: first_movie_year {
#     description: "Based on Main Roles only"
    type: number
  }

  dimension: last_movie_year {
#     description: "Based on Main Roles only"
    type: number
  }

  dimension: total_main_roles_count {
    type: number
  }

  dimension: total_secondary_roles_count {
    type: number
  }

  dimension: career_length {
#     description: "Based on Main Roles only"
    type: number
    sql: ${last_movie_year} - ${first_movie_year} + 1 ;;
  }

  dimension: average_main_roles_by_year {
    description: "Average number of Main Roles by year of career"
    type: number
    value_format_name: decimal_1
    sql: ${total_main_roles_count} / ${career_length} ;;
  }

  set: facts {
    fields:
    [
      total_movies_count,
      first_movie_year,
      last_movie_year,
      career_length,
      total_main_roles_count,
      total_secondary_roles_count,
      average_main_roles_by_year
    ]
  }
}
