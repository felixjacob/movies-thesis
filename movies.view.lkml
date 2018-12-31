view: movies {
  sql_table_name: movies_data.movies_metadata ;;

  dimension: movie_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: adult {
    type: yesno
    sql: ${TABLE}.adult ;;
  }

  dimension: belongs_to_collection {
    type: string
    sql: ${TABLE}.belongs_to_collection ;;
  }

  dimension: budget {
    type: number
    sql: ${TABLE}.budget ;;
  }

  dimension: genres {
    type: string
    sql: ${TABLE}.genres ;;
  }

  dimension: homepage {
    type: string
    sql: ${TABLE}.homepage ;;
  }

  dimension: imdb_id {
    type: string
    sql: ${TABLE}.imdb_id ;;
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

  dimension: popularity {
    type: number
    sql: ${TABLE}.popularity ;;
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

  dimension: video {
    type: yesno
    sql: ${TABLE}.video ;;
  }

  dimension: vote_average {
    type: number
    sql: ${TABLE}.vote_average ;;
  }

  dimension: vote_count {
    type: number
    sql: ${TABLE}.vote_count ;;
  }

  measure: count {
    type: count
    drill_fields: [movie_id]
  }
}
