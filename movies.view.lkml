view: movies {
  # sql_table_name: movies_data.movies_metadata ;;

  derived_table: {
    datagroup_trigger: movies_thesis_default_datagroup
    sql:
    SELECT DISTINCT
      id AS movie_id,
      belongs_to_collection,
      budget,
      homepage,
      original_language,
      original_title,
      overview,
      poster_path,
      production_companies,
      production_countries,
      release_date,
      revenue,
      runtime,
      spoken_languages,
      status,
      tagline,
      title
    FROM movies_data.movies_metadata ;;
  }

  dimension: movie_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.movie_id ;;
  }

  dimension: belongs_to_collection {
    type: string
    sql: ${TABLE}.belongs_to_collection ;;
  }

  dimension: budget {
    type: number
    sql: ${TABLE}.budget ;;
  }

  dimension: homepage {
    type: string
    sql: ${TABLE}.homepage ;;
  }

  dimension: original_language {
    type: string
    sql: ${TABLE}.original_language ;;
  }

  dimension: original_title {
    type: string
    sql: ${TABLE}.original_title ;;
  }

  dimension: overview {
    type: string
    sql: ${TABLE}.overview ;;
  }

  dimension: poster_path {
    type: string
    sql: ${TABLE}.poster_path ;;
  }

  dimension: production_companies {
    type: string
    sql: ${TABLE}.production_companies ;;
  }

  dimension: production_countries {
    type: string
    sql: ${TABLE}.production_countries ;;
  }

  dimension_group: release {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.release_date ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }

  dimension: runtime {
    type: number
    sql: ${TABLE}.runtime ;;
  }

  dimension: spoken_languages {
    type: string
    sql: ${TABLE}.spoken_languages ;;
  }

  dimension: status {
    hidden: yes
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: tagline {
    type: string
    sql: ${TABLE}.tagline ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  measure: count {
    type: count
    drill_fields: [movie_id]
  }
}
