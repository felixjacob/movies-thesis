view: actor_facts {
  derived_table: {
    explore_source: actors {
      column: actor_name {}
      column: total_movies_count { field: actors.count_movies_released }
    }
  }
  dimension: actor_name {}
  dimension: total_movies_count {
    type: number
  }
}
