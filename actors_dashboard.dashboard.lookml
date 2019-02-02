- dashboard: actors_dashboard
  title: Actors Dashboard
  layout: newspaper
  elements:
  - title: Actor Name
    name: Actor Name
    model: movies_thesis
    explore: actors
    type: single_value
    fields:
    - actors.actor_name_big
    sorts:
    - actors.actor_name_big
    limit: 1
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    listen:
      Id: actors.actor_id
    row: 0
    col: 0
    width: 12
    height: 3
  - title: Picture
    name: Picture
    model: movies_thesis
    explore: actors
    type: single_value
    fields:
    - actors.picture_big
    sorts:
    - actors.picture_big
    limit: 500
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: false
    series_types: {}
    listen:
      Id: actors.actor_id
    row: 0
    col: 18
    width: 6
    height: 11
  - title: All Time Average Rating
    name: All Time Average Rating
    model: movies_thesis
    explore: actors
    type: single_value
    fields:
    - ratings_summary.average_rating
    limit: 500
    show_view_names: 'true'
    series_types: {}
    note_state: collapsed
    note_display: hover
    note_text: Based on main and secondary roles
    listen:
      Id: actors.actor_id
    row: 3
    col: 0
    width: 6
    height: 4
  - title: All Time Ratings
    name: All Time Ratings
    model: movies_thesis
    explore: actors
    type: single_value
    fields:
    - ratings_summary.rating_count
    limit: 500
    show_view_names: 'true'
    series_types: {}
    note_state: collapsed
    note_display: hover
    note_text: Based on main and secondary roles
    listen:
      Id: actors.actor_id
    row: 3
    col: 6
    width: 6
    height: 4
  - title: Favourite Genre
    name: Favourite Genre
    model: movies_thesis
    explore: actors
    type: single_value
    fields:
    - genres.genre
    - movies.movies_count
    sorts:
    - movies.movies_count desc 0
    - genres.genre desc
    limit: 1
    show_view_names: 'true'
    series_types: {}
    hidden_fields:
    - movies.movies_count
    note_state: collapsed
    note_display: hover
    note_text: Based on main and secondary roles
    listen:
      Id: actors.actor_id
    row: 7
    col: 0
    width: 6
    height: 4
  - title: Movies Starred In
    name: Movies Starred In
    model: movies_thesis
    explore: actors
    type: single_value
    fields:
    - movies.movies_count
    limit: 500
    show_view_names: 'true'
    series_types: {}
    note_state: collapsed
    note_display: hover
    note_text: Based on main and secondary roles
    listen:
      Id: actors.actor_id
    row: 7
    col: 6
    width: 6
    height: 4
  - title: Highest Grossing Movie
    name: Highest Grossing Movie
    model: movies_thesis
    explore: actors
    type: single_value
    fields:
    - movies.revenue
    - movies.poster_revenue
    sorts:
    - movies.revenue desc
    limit: 1
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: 'true'
    series_types: {}
    hidden_fields:
    - movies.revenue
    note_state: collapsed
    note_display: hover
    note_text: Based on main and secondary roles
    listen:
      Id: actors.actor_id
    row: 3
    col: 12
    width: 6
    height: 8
  - title: Best 5 Movies
    name: Best 5 Movies
    model: movies_thesis
    explore: actors
    type: table
    fields:
    - movies.release_year
    - movies.title
    - actors.character_name
    - ratings_summary.average_rating
    - genres.all_genres
    filters:
      actors.role_type: Main
    sorts:
    - ratings_summary.average_rating desc
    limit: 5
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    note_state: collapsed
    note_display: hover
    note_text: Based on main roles
    listen:
      Id: actors.actor_id
    row: 11
    col: 0
    width: 12
    height: 5
  - title: Worst 5 Movies
    name: Worst 5 Movies
    model: movies_thesis
    explore: actors
    type: table
    fields:
    - movies.release_year
    - movies.title
    - actors.character_name
    - ratings_summary.average_rating
    - genres.all_genres
    filters:
      actors.role_type: Main
    sorts:
    - ratings_summary.average_rating
    limit: 5
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    note_state: collapsed
    note_display: hover
    note_text: Based on main roles
    listen:
      Id: actors.actor_id
    row: 11
    col: 12
    width: 12
    height: 5
  - title: Role type breakdown by genre
    name: Role type breakdown by genre
    model: movies_thesis
    explore: actors
    type: sankey
    fields:
    - actors.role_type
    - genres.genre
    - movies.movies_count
    sorts:
    - genres.genre
    - actors.role_type
    limit: 500
    query_timezone: UTC
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: circle_outline
    series_types: {}
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    y_axes:
    - label: ''
      orientation: left
      series:
      - id: cumulative_main_roles_count
        name: Cumulative Main Roles Count
        axisId: cumulative_main_roles_count
        __FILE: movies_thesis/actors_dashboard.dashboard.lookml
        __LINE_NUM: 470
      - id: cumulative_secondary_roles_count
        name: Cumulative Secondary Roles Count
        axisId: cumulative_secondary_roles_count
        __FILE: movies_thesis/actors_dashboard.dashboard.lookml
        __LINE_NUM: 473
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      __FILE: movies_thesis/actors_dashboard.dashboard.lookml
      __LINE_NUM: 467
    - label:
      orientation: right
      series:
      - id: cumulative_rating
        name: Cumulative Rating
        axisId: cumulative_rating
        __FILE: movies_thesis/actors_dashboard.dashboard.lookml
        __LINE_NUM: 485
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      __FILE: movies_thesis/actors_dashboard.dashboard.lookml
      __LINE_NUM: 482
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    show_null_points: false
    interpolation: linear
    discontinuous_nulls: true
    hidden_fields:
    - cumulative_rating_count
    - cumulative_rating_sumproduct
    note_state: collapsed
    note_display: hover
    note_text: Movies can have more than one genre, so total amount of roles in this
      chart can be greater than the total amount of movies in the scorecard above.
    listen:
      Id: actors.actor_id
    row: 16
    col: 12
    width: 12
    height: 9
  - title: Index of Fame
    name: Index of Fame
    model: movies_thesis
    explore: actors
    type: single_value
    fields:
    - actors_ranks_final.actor_rank
    sorts:
    - actors_ranks_final.actor_rank desc
    limit: 500
    show_view_names: 'true'
    series_types: {}
    note_state: collapsed
    note_display: hover
    note_text: |-
      Based on total movies, average rating and average revenue, only for main roles and movies with more than 500 ratings.
      Actors with less than 5 movies matching these criteria will have a rank equal to NULL.
    listen:
      Id: actors.actor_id
    row: 0
    col: 12
    width: 6
    height: 3
  - title: Career summary
    name: Career summary
    model: movies_thesis
    explore: actors
    type: looker_line
    fields:
    - movies.years_from_start_of_career
    - ratings_summary.average_rating
    - actors.main_roles_count
    - actors.secondary_roles_count
    - ratings_summary.rating_count
    - ratings_summary.rating_sumproduct
    sorts:
    - movies.years_from_start_of_career
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: cumulative_rating
      label: Cumulative Rating
      expression: "${cumulative_rating_sumproduct} / ${cumulative_rating_count}"
      value_format:
      value_format_name: decimal_1
      _kind_hint: measure
      _type_hint: number
    - table_calculation: cumulative_main_roles_count
      label: Cumulative Main Roles Count
      expression: running_total(${actors.main_roles_count})
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: cumulative_secondary_roles_count
      label: Cumulative Secondary Roles Count
      expression: running_total(${actors.secondary_roles_count})
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: cumulative_rating_count
      label: Cumulative Rating Count
      expression: running_total(${ratings_summary.rating_count})
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: cumulative_rating_sumproduct
      label: Cumulative Rating Sumproduct
      expression: running_total(${ratings_summary.rating_sumproduct})
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: circle_outline
    series_colors:
      cumulative_main_roles_count: "#a6cee3"
      cumulative_secondary_roles_count: "#dcb7cf"
      ratings_summary.average_rating: "#F16358"
      cumulative_rating: "#626262"
    series_types:
      cumulative_main_roles_count: column
      cumulative_secondary_roles_count: column
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    hidden_series:
    - cumulative_secondary_roles_count
    y_axes:
    - label: ''
      orientation: left
      series:
      - id: cumulative_main_roles_count
        name: Cumulative Main Roles Count
        axisId: cumulative_main_roles_count
      - id: cumulative_secondary_roles_count
        name: Cumulative Secondary Roles Count
        axisId: cumulative_secondary_roles_count
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
    - label:
      orientation: right
      series:
      - id: cumulative_rating
        name: Cumulative Rating
        axisId: cumulative_rating
      - id: ratings_summary.average_rating
        name: Average Rating
        axisId: ratings_summary.average_rating
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    reference_lines: []
    show_null_points: false
    interpolation: linear
    discontinuous_nulls: true
    query_timezone: UTC
    hidden_fields:
    - actors.main_roles_count
    - ratings_summary.rating_count
    - ratings_summary.rating_sumproduct
    - cumulative_rating_count
    - cumulative_rating_sumproduct
    - actors.secondary_roles_count
    note_state: collapsed
    note_display: hover
    note_text: |-
      Cumulative number of main and second roles by year of career.
      Cumulative rating is the average rating of all movies up to a given year in the actor's career.
    listen:
      Id: actors.actor_id
    row: 16
    col: 0
    width: 12
    height: 9
  filters:
  - name: Id
    title: Id
    type: field_filter
    default_value: '4173'
    allow_multiple_values: false
    required: false
    model: movies_thesis
    explore: actors
    listens_to_filters:
    - Name
    field: actors.actor_id
