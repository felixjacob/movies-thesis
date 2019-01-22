view: actors_facts {
  derived_table: {
    explore_source: actors {
      column: actor_id {}
      column: total_movies_count { field: movies.movies_count }
    }
  }

  dimension: actor_id {
    primary_key: yes
    type: number
  }

  dimension: total_movies_count {
    type: number
  }
}
