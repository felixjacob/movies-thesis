- dashboard: thesis_presentation
  title: Thesis Presentation
  layout: newspaper
  elements:
  - title: Roles by genres and gender
    name: Roles by genres and gender
    model: movies_thesis
    explore: actors
    type: looker_column
    fields:
    - people.gender
    - genres.genre
    - people.roles_count
    pivots:
    - people.gender
    filters:
      people.gender: "-NULL"
    sorts:
    - people.gender 0
    - female desc
    limit: 500
    row_total: right
    dynamic_fields:
    - table_calculation: female
      label: Female %
      expression: pivot_where(${people.gender} = "Female", ${people.roles_count})/${people.roles_count:row_total}
      value_format:
      value_format_name: percent_1
      _kind_hint: supermeasure
      _type_hint: number
    query_timezone: UTC
    stacking: percent
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: circle_outline
    series_colors:
      1 - movies.movies_count: "#1ea8df"
      2 - movies.movies_count: "#e9b404"
      Female - movies.movies_count: "#5245ed"
      Male - movies.movies_count: "#e9b404"
      Female - people.roles_count: "#3D6D9E"
      Male - people.roles_count: "#e7e7e7"
    series_labels:
      2 - movies.movies_count: Male
      1 - movies.movies_count: Female
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
    reference_lines:
    - reference_type: line
      range_start: max
      range_end: min
      margin_top: deviation
      margin_value: mean
      margin_bottom: deviation
      label_position: center
      color: "#000000"
      line_value: '0.5'
    ordering: asc
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: false
    interpolation: linear
    discontinuous_nulls: true
    hidden_fields:
    - cumulative_rating_count
    - cumulative_rating_sumproduct
    - calculation_1
    - female
    listen: {}
    row: 68
    col: 4
    width: 16
    height: 8
  - title: Female Roles
    name: Female Roles
    model: movies_thesis
    explore: actors
    type: single_value
    fields:
    - people.roles_count
    - people.gender
    pivots:
    - people.gender
    filters:
      people.gender: "-NULL"
    sorts:
    - people.roles_count desc 0
    - people.gender
    limit: 500
    row_total: right
    dynamic_fields:
    - table_calculation: of_female_roles
      label: "% of Female Roles"
      expression: pivot_where(${people.gender}="Female",${people.roles_count})/${people.roles_count:row_total}
      value_format:
      value_format_name: percent_1
      _kind_hint: supermeasure
      _type_hint: number
    query_timezone: UTC
    value_labels: legend
    label_type: labPer
    series_colors:
      1 - movies.movies_count: "#1ea8df"
      2 - movies.movies_count: "#e9b404"
      Female: "#5245ed"
      Male: "#e9b404"
    series_labels:
      2 - movies.movies_count: Male
      1 - movies.movies_count: Female
    stacking: percent
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
    ordering: asc
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: false
    interpolation: linear
    discontinuous_nulls: true
    hidden_fields:
    - cumulative_rating_count
    - cumulative_rating_sumproduct
    - people.roles_count
    listen: {}
    row: 57
    col: 9
    width: 6
    height: 3
  - title: Genres Overlaps
    name: Genres Overlaps
    model: movies_thesis
    explore: genres_overlaps
    type: chord
    fields:
    - genres_overlaps.genre1
    - genres_overlaps.genre2
    - genres_overlaps.count
    filters:
      genres_overlaps.count: not 0
    sorts:
    - genres_overlaps.count desc
    limit: 500
    dynamic_fields:
    - table_calculation: keep_in_viz
      label: keep_in_viz
      expression: "${genres_overlaps.count} > 1000"
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: yesno
    query_timezone: UTC
    color_range:
    - "#8dd3c7"
    - "#ffed6f"
    - "#bebada"
    - "#fb8072"
    - "#80b1d3"
    - "#fdb462"
    - "#b3de69"
    - "#fccde5"
    - "#d9d9d9"
    - "#bc80bd"
    - "#ccebc5"
    - "#a3a3ff"
    series_types: {}
    hidden_points_if_no:
    - keep_in_viz
    hidden_fields:
    - calculation_1
    - keep_in_viz
    listen: {}
    row: 44
    col: 0
    width: 12
    height: 9
  - title: Genres Overlaps - Data
    name: Genres Overlaps - Data
    model: movies_thesis
    explore: genres_overlaps
    type: table
    fields:
    - genres_overlaps.genre1
    - genres_overlaps.genre2
    - genres_overlaps.count
    filters:
      genres_overlaps.count: not 0
    sorts:
    - genres_overlaps.count desc 0
    - genres_overlaps.genre1
    - genres_overlaps.genre2
    limit: 500
    dynamic_fields:
    - table_calculation: odd_or_even
      label: odd_or_even
      expression: mod(row(), 2) = 0
      value_format:
      value_format_name:
      _kind_hint: dimension
      _type_hint: yesno
    query_timezone: UTC
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      genres_overlaps.count: Movies with both genres
      genres_overlaps.genre1: Genre 1
      genres_overlaps.genre2: Genre 2
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_range:
    - "#8dd3c7"
    - "#ffed6f"
    - "#bebada"
    - "#fb8072"
    - "#80b1d3"
    - "#fdb462"
    - "#b3de69"
    - "#fccde5"
    - "#d9d9d9"
    - "#bc80bd"
    - "#ccebc5"
    - "#a3a3ff"
    series_types: {}
    hidden_points_if_no:
    - odd_or_even
    hidden_fields:
    - calculation_1
    listen: {}
    row: 44
    col: 12
    width: 12
    height: 9
  - name: Genres in Movies
    type: text
    title_text: Genres in Movies
    row: 33
    col: 0
    width: 24
    height: 4
  - name: Ranking Actors
    type: text
    title_text: Ranking Actors
    row: 76
    col: 0
    width: 24
    height: 4
  - title: Actors Ranks
    name: Actors Ranks
    model: movies_thesis
    explore: actors
    type: table
    fields:
    - actors_ranks_final.actor_rank_medium
    - people.picture_small
    - people.actor_name_medium
    filters:
      actors_ranks_final.actor_rank: NOT NULL
    sorts:
    - actors_ranks_final.actor_rank_medium
    limit: 500
    query_timezone: UTC
    show_view_names: true
    show_row_numbers: false
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      people.picture_small: Picture
      people.actor_name: Name
      people.actor_name_medium: Name
      actors_ranks_final.actor_rank: Rank
      actors_ranks_final.actor_rank_medium: Rank
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      Total Movies | Rank Order: actors_ranks_final.total_movies_rank_order
      Average Rating | Rank Order: actors_ranks_final.average_rating_rank_order
      Average Rating | Weight: actors_ranks_final.average_rating_weight
      Total Movies | Weight: actors_ranks_final.total_movies_weight
      Average Revenue | Rank Order: actors_ranks_final.average_revenue_rank_order
      Average Revenue | Weight: actors_ranks_final.average_revenue_weight
    row: 80
    col: 6
    width: 12
    height: 12
  - title: "% of Female Roles by Year"
    name: "% of Female Roles by Year"
    model: movies_thesis
    explore: actors
    type: looker_column
    fields:
    - movies.release_year
    - people.roles_count
    - people.gender
    pivots:
    - people.gender
    fill_fields:
    - movies.release_year
    filters:
      people.gender: "-NULL"
    sorts:
    - movies.release_year desc
    - people.gender
    limit: 500
    row_total: right
    dynamic_fields:
    - table_calculation: of_female_roles
      label: "% of Female Roles"
      expression: pivot_where(${people.gender}="Female", ${people.roles_count})/${people.roles_count:row_total}
      value_format:
      value_format_name: percent_1
      _kind_hint: supermeasure
      _type_hint: number
    - table_calculation: keep_in_viz
      label: keep_in_viz
      expression: "${people.roles_count:row_total} >= 200"
      value_format:
      value_format_name:
      _kind_hint: supermeasure
      _type_hint: yesno
    query_timezone: UTC
    stacking: normal
    color_application:
      collection_id: legacy
      palette_id: black_to_gray
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors:
      Male - people.main_roles_count: "#d0d0d0"
      Female - people.main_roles_count: "#3D6D9E"
      Male - of_total: "#d0d0d0"
      Female - of_total: "#3D6D9E"
      Female - of_total_main_roles: "#3D6D9E"
      Male - of_total_main_roles: "#d0d0d0"
      of_female_main_roles: "#3D6D9E"
      of_female_roles: "#764173"
    series_types:
      of_female_main_roles: area
      of_female_roles: area
    limit_displayed_rows: false
    hidden_series:
    - of_female_main_roles
    y_axes:
    - label: ''
      orientation: left
      series:
      - id: of_female_main_roles
        name: "% of Female Main Roles"
        axisId: of_female_main_roles
      showLabels: true
      showValues: true
      maxValue: 0.5
      minValue: 0
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    reference_lines:
    - reference_type: line
      line_value: max
      range_start: max
      range_end: min
      margin_top: deviation
      margin_value: mean
      margin_bottom: deviation
      label_position: center
      color: "#000000"
      label: ''
    - reference_type: line
      line_value: min
      range_start: max
      range_end: min
      margin_top: deviation
      margin_value: mean
      margin_bottom: deviation
      label_position: center
      color: "#000000"
    trend_lines: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    - calculation_2
    - keep_in_viz
    - people.roles_count
    hidden_points_if_no:
    - calculation_2
    - keep_in_viz
    listen: {}
    row: 60
    col: 4
    width: 16
    height: 8
  - name: Gender in Movies
    type: text
    title_text: Gender in Movies
    row: 53
    col: 0
    width: 24
    height: 4
  - title: Movies by Genre
    name: Movies by Genre
    model: movies_thesis
    explore: movies
    type: looker_column
    fields:
    - genres.genre
    - movies.movies_count
    limit: 500
    stacking: ''
    color_application:
      collection_id: legacy
      palette_id: mixed_dark
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors: {}
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    row: 37
    col: 4
    width: 16
    height: 7
  - title: Movies Released by Year
    name: Movies Released by Year
    model: movies_thesis
    explore: movies
    type: looker_column
    fields:
    - movies.release_year
    - movies.movies_count
    - ratings_summary.rating_count
    fill_fields:
    - movies.release_year
    sorts:
    - movies.release_year desc
    limit: 500
    query_timezone: UTC
    stacking: ''
    color_application:
      collection_id: legacy
      palette_id: random
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors: {}
    series_types:
      ratings_summary.rating_count: area
      movies.movies_count: area
    limit_displayed_rows: false
    hidden_series:
    - ratings_summary.rating_count
    y_axes:
    - label: ''
      orientation: left
      series:
      - id: movies.movies_count
        name: Movies Count
        axisId: movies.movies_count
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
    - label:
      orientation: right
      series:
      - id: ratings_summary.rating_count
        name: Rating Count
        axisId: ratings_summary.rating_count
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
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: time
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trend_lines:
    - color: "#000000"
      label_position: right
      period: 7
      regression_type: exponential
      series_index: 1
      show_label: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen: {}
    row: 8
    col: 4
    width: 16
    height: 9
  - title: Movies
    name: Movies
    model: movies_thesis
    explore: movies
    type: single_value
    fields:
    - movies.movies_count
    limit: 500
    query_timezone: UTC
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_types: {}
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trend_lines: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen: {}
    row: 4
    col: 4
    width: 4
    height: 4
  - title: Highest Revenue
    name: Highest Revenue
    model: movies_thesis
    explore: movies
    type: single_value
    fields:
    - movies.revenue
    - movies.poster_revenue
    filters:
      movies.release_year: 40 years
    sorts:
    - movies.revenue desc
    limit: 1
    query_timezone: UTC
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_types: {}
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trend_lines: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    - movies.revenue
    listen: {}
    row: 17
    col: 12
    width: 5
    height: 8
  - title: Biggest Budget
    name: Biggest Budget
    model: movies_thesis
    explore: movies
    type: single_value
    fields:
    - movies.poster_budget
    - movies.budget
    filters:
      movies.release_year: 40 years
    sorts:
    - movies.budget desc
    limit: 1
    query_timezone: UTC
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_types: {}
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trend_lines: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    - movies.budget
    listen: {}
    row: 17
    col: 7
    width: 5
    height: 8
  - title: Smallest Budget
    name: Smallest Budget
    model: movies_thesis
    explore: movies
    type: single_value
    fields:
    - movies.poster_budget
    - movies.budget
    filters:
      movies.budget: ">=1000,NOT NULL"
      ratings_summary.rating_count: ">=500"
      movies.release_year: 40 years
      movies.revenue: ">=1000,NOT NULL"
    sorts:
    - movies.budget
    limit: 1
    query_timezone: UTC
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_types: {}
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trend_lines: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    - movies.budget
    listen: {}
    row: 25
    col: 7
    width: 5
    height: 8
  - title: Lowest Revenue
    name: Lowest Revenue
    model: movies_thesis
    explore: movies
    type: single_value
    fields:
    - movies.poster_revenue
    - movies.revenue
    filters:
      movies.budget: ">=1000,NOT NULL"
      ratings_summary.rating_count: ">=500"
      movies.release_year: 40 years
      movies.revenue: ">=1000,NOT NULL"
    sorts:
    - movies.revenue
    limit: 1
    query_timezone: UTC
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_types: {}
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trend_lines: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: []
    listen: {}
    row: 25
    col: 12
    width: 5
    height: 8
  - title: Actors
    name: Actors
    model: movies_thesis
    explore: actors
    type: single_value
    fields:
    - people.actors_count
    limit: 500
    show_view_names: 'true'
    series_types: {}
    listen: {}
    row: 4
    col: 8
    width: 4
    height: 4
  - title: Roles
    name: Roles
    model: movies_thesis
    explore: actors
    type: single_value
    fields:
    - people.roles_count
    limit: 500
    show_view_names: 'true'
    series_types: {}
    listen: {}
    row: 4
    col: 12
    width: 4
    height: 4
  - name: Overview
    type: text
    title_text: Overview
    subtitle_text: Some facts about the data
    row: 0
    col: 0
    width: 24
    height: 4
  - title: Ratings
    name: Ratings
    model: movies_thesis
    explore: movies
    type: single_value
    fields:
    - ratings_summary.rating_count
    limit: 500
    query_timezone: UTC
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_types: {}
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trend_lines: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen: {}
    row: 4
    col: 16
    width: 4
    height: 4
  filters:
  - name: Total Movies | Weight
    title: Total Movies | Weight
    type: field_filter
    default_value: '1'
    allow_multiple_values: true
    required: false
    model: movies_thesis
    explore: actors_ranks_final
    listens_to_filters: []
    field: actors_ranks_final.total_movies_weight
  - name: Total Movies | Rank Order
    title: Total Movies | Rank Order
    type: field_filter
    default_value: Descending
    allow_multiple_values: true
    required: false
    model: movies_thesis
    explore: actors_ranks_final
    listens_to_filters: []
    field: actors_ranks_final.total_movies_rank_order
  - name: Average Rating | Weight
    title: Average Rating | Weight
    type: field_filter
    default_value: '1'
    allow_multiple_values: true
    required: false
    model: movies_thesis
    explore: actors_ranks_final
    listens_to_filters: []
    field: actors_ranks_final.average_rating_weight
  - name: Average Rating | Rank Order
    title: Average Rating | Rank Order
    type: field_filter
    default_value: Descending
    allow_multiple_values: true
    required: false
    model: movies_thesis
    explore: actors_ranks_final
    listens_to_filters: []
    field: actors_ranks_final.average_rating_rank_order
  - name: Average Revenue | Weight
    title: Average Revenue | Weight
    type: field_filter
    default_value: '1'
    allow_multiple_values: true
    required: false
    model: movies_thesis
    explore: actors_ranks_final
    listens_to_filters: []
    field: actors_ranks_final.average_revenue_weight
  - name: Average Revenue | Rank Order
    title: Average Revenue | Rank Order
    type: field_filter
    default_value: Descending
    allow_multiple_values: true
    required: false
    model: movies_thesis
    explore: actors_ranks_final
    listens_to_filters: []
    field: actors_ranks_final.average_revenue_rank_order
