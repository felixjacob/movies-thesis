view: actors_ranks {
  derived_table: {
    datagroup_trigger: movies_thesis_default_datagroup
    explore_source: actors {
      column: actor_id {}
      column: total_movies_count { field: movies.movies_count }
      column: average_rating { field: ratings_summary.average_rating }
      column: average_revenue { field: movies.average_revenue }
      derived_column: total_movies_rank {
        sql: RANK() OVER (ORDER BY total_movies_count DESC) ;;
      }
      derived_column: rating_rank {
        sql: RANK() OVER (ORDER BY average_rating DESC) ;;
      }
      derived_column: revenue_rank {
        sql: RANK() OVER (ORDER BY average_revenue DESC) ;;
      }
      filters: {
        field: actors.role_type
        value: "Main"
      }
      filters: {
        field: movies.movies_count
        value: ">=5"
      }
      filters: {
        field: ratings_summary.total_ratings
        value: ">=500"
      }
    }
  }

  dimension: actor_id {
    primary_key: yes
    type: number
  }

  dimension: total_movies_count {
    type: number
  }

  dimension: average_rating {
    value_format_name: decimal_1
    type: number
  }

  dimension: average_revenue {
    value_format_name: usd_0
    type: number
  }

  dimension: total_movies_rank {
    type: number
  }

  dimension: rating_rank {
    type: number
  }

  dimension: revenue_rank {
    type: number
  }

  dimension: overall_rank_sum {
    type: number
    sql: ${total_movies_rank} + ${rating_rank} + ${revenue_rank} ;;
  }

  dimension: overall_rank_sum_inverted {
    type: number
    sql: 1 / ${overall_rank_sum} ;;
  }
}

view: actors_ranks_final {
  derived_table: {
    explore_source: actors_ranks {
      column: actor_id {}
      column: average_rating {}
      column: average_revenue {}
      column: total_movies_count {}
      column: rating_rank {}
      column: revenue_rank {}
      column: total_movies_rank {}
      column: overall_rank_sum {}
      column: overall_rank_sum_inverted {}
      derived_column: actor_rank {
        sql: RANK() OVER (ORDER BY overall_rank_sum_inverted DESC) ;;
      }
    }
  }
  dimension: actor_id {
    primary_key: yes
    type: number
  }

  dimension: total_movies_count {
    type: number
  }

  dimension: average_rating {
    value_format_name: decimal_1
    type: number
  }

  dimension: average_revenue {
    value_format_name: usd_0
    type: number
  }

  dimension: total_movies_rank {
    type: number
  }

  dimension: rating_rank {
    type: number
  }

  dimension: revenue_rank {
    type: number
  }

  dimension: overall_rank_sum {
    type: number
  }

  dimension: overall_rank_sum_inverted {
    type: number
  }

  dimension: actor_rank {
    type: number
  }
}
