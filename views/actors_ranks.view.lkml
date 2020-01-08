include: "/models/movies_thesis.model.lkml"

view: actors_ranks {
  derived_table: {
    datagroup_trigger: movies_thesis_default_datagroup
    explore_source: actors {
      column: actor_id { field: people.actor_id }
      column: total_movies_count { field: movies.movies_count }
      column: average_rating { field: ratings_summary.average_rating }
      column: average_revenue { field: movies.average_revenue }
      derived_column: total_movies_rank_desc {
        sql: RANK() OVER (ORDER BY total_movies_count DESC) ;;
      }
      derived_column: total_movies_rank_asc {
        sql: RANK() OVER (ORDER BY total_movies_count ASC) ;;
      }
      derived_column: rating_rank_desc {
        sql: RANK() OVER (ORDER BY average_rating DESC) ;;
      }
      derived_column: rating_rank_asc {
        sql: RANK() OVER (ORDER BY average_rating ASC) ;;
      }
      derived_column: revenue_rank_desc {
        sql: RANK() OVER (ORDER BY average_revenue DESC) ;;
      }
      derived_column: revenue_rank_asc{
        sql: RANK() OVER (ORDER BY average_revenue ASC) ;;
      }
      filters: {
        field: people.role_type
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

#   parameter: total_movies_rank_order {
#     type: unquoted
#     default_value: "Descending"
#     allowed_value: {
#       value: "Ascending"
#     }
#     allowed_value: {
#       value: "Descending"
#     }
#   }
#
#   parameter: average_rating_rank_order {
#     type: unquoted
#     default_value: "Descending"
#     allowed_value: {
#       value: "Ascending"
#     }
#     allowed_value: {
#       value: "Descending"
#     }
#   }
#
#   parameter: average_revenue_rank_order {
#     type: unquoted
#     default_value: "Descending"
#     allowed_value: {
#       value: "Ascending"
#     }
#     allowed_value: {
#       value: "Descending"
#     }
#   }

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

  dimension: total_movies_rank_desc {
    type: number
  }

  dimension: total_movies_rank_asc {
    type: number
  }

  dimension: rating_rank_desc {
    type: number
  }

  dimension: rating_rank_asc {
    type: number
  }

  dimension: revenue_rank_desc {
    type: number
  }

  dimension: revenue_rank_asc {
    type: number
  }

#   dimension: overall_rank_sum {
#     type: number
#     sql:
#     {% if total_movies_rank_order._parameter_value == 'Ascending' %} ${total_movies_rank_asc}
#     {% else %} ${total_movies_rank_desc} {% endif %}
#     {% if average_rating_rank_order._parameter_value == 'Ascending' %} + ${rating_rank_asc}
#     {% else %} + ${rating_rank_desc} {% endif %}
#     {% if average_revenue_rank_order._parameter_value == 'Ascending' %} + ${revenue_rank_asc}
#     {% else %} + ${revenue_rank_desc} {% endif %}
#     ;;
#   }
#
#   dimension: overall_rank_sum_inverted {
#     type: number
#     sql: 1 / ${overall_rank_sum} ;;
#   }
}


####################################################################################################

view: actors_ranks_final {
  derived_table: {
    explore_source: actors_ranks {
      column: actor_id {}
      column: average_rating {}
      column: average_revenue {}
      column: total_movies_count {}
      column: total_movies_rank_desc {}
      column: total_movies_rank_asc {}
      column: rating_rank_desc {}
      column: rating_rank_asc {}
      column: revenue_rank_desc {}
      column: revenue_rank_asc {}
      derived_column: actor_rank {
        sql: RANK() OVER (ORDER BY
          (1 / NULLIF(
            IFNULL((1 / NULLIF({% parameter total_movies_weight %}, 0)) *
            {% if actors_ranks_final.total_movies_rank_order._parameter_value == 'Ascending' %} total_movies_rank_asc
            {% else %} total_movies_rank_desc {% endif %}, 0)
            + IFNULL((1 / NULLIF({% parameter average_rating_weight %}, 0)) *
            {% if actors_ranks_final.average_rating_rank_order._parameter_value == 'Ascending' %} rating_rank_asc
            {% else %} + rating_rank_desc {% endif %}, 0)
            + IFNULL((1 / NULLIF({% parameter average_revenue_weight %}, 0)) *
            {% if actors_ranks_final.average_revenue_rank_order._parameter_value == 'Ascending' %} revenue_rank_asc
            {% else %} + revenue_rank_desc {% endif %}, 0)
          , 0)
          ) DESC);;
      }
    }
  }

  parameter: total_movies_rank_order {
    type: unquoted
    default_value: "Descending"
    allowed_value: {
      value: "Ascending"
    }
    allowed_value: {
      value: "Descending"
    }
  }

  parameter: total_movies_weight {
    type: number
    default_value: "1"
  }

  parameter: average_rating_rank_order {
    type: unquoted
    default_value: "Descending"
    allowed_value: {
      value: "Ascending"
    }
    allowed_value: {
      value: "Descending"
    }
  }

  parameter: average_rating_weight {
    type: number
    default_value: "1"
  }

  parameter: average_revenue_rank_order {
    type: unquoted
    default_value: "Descending"
    allowed_value: {
      value: "Ascending"
    }
    allowed_value: {
      value: "Descending"
    }
  }

  parameter: average_revenue_weight {
    type: number
    default_value: "1"
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

  dimension: total_movies_rank_desc {
    type: number
  }

  dimension: total_movies_rank_asc {
    type: number
  }

  dimension: rating_rank_desc {
    type: number
  }

  dimension: rating_rank_asc {
    type: number
  }

  dimension: revenue_rank_desc {
    type: number
  }

  dimension: revenue_rank_asc {
    type: number
  }

  dimension: actor_rank {
    group_label: "Rank"
    type: number
  }

  dimension: actor_rank_medium {
    group_label: "Rank"
    type: number
    sql: ${actor_rank} ;;
    html: <center><b><font size="5px">{{value}}</font></b></center> ;;
  }

  set: ranks {
    fields:
    [
      total_movies_rank_order,
      total_movies_weight,
      average_rating_rank_order,
      average_rating_weight,
      average_revenue_rank_order,
      average_revenue_weight,
      actor_rank,
      actor_rank_medium
    ]
  }
}
