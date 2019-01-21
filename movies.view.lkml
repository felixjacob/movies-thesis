view: movies {
  # sql_table_name: movies_data.movies_metadata ;;

  derived_table: {
    datagroup_trigger: movies_thesis_default_datagroup
    sql:
    SELECT DISTINCT
      id AS movie_id,
      belongs_to_collection,
      NULLIF(budget, 0) AS budget,
      homepage,
      imdb_id,
      original_language,
      original_title,
      overview,
      poster_path,
      production_companies,
      production_countries,
      release_date,
      NULLIF(revenue, 0) AS revenue,
      runtime,
      spoken_languages,
      status,
      tagline,
      title
    FROM movies_data.movies_metadata
    WHERE runtime BETWEEN 60 AND 240
      AND genres <> '[]'
    ;;
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
    value_format_name: usd_0
    sql: ${TABLE}.budget ;;
  }

  dimension: homepage {
    type: string
    sql: ${TABLE}.homepage ;;
  }

  dimension: imdb_id {
    hidden: yes
    type: string
    sql: ${TABLE}.imdb_id ;;
  }

  dimension: original_language {
    type: string
    sql: UPPER(${TABLE}.original_language) ;;
  }

  dimension: original_title {
    type: string
    sql: ${TABLE}.original_title ;;
  }

  dimension: overview {
    type: string
    sql: ${TABLE}.overview ;;
  }

  dimension: poster {
    group_label: "Poster"
    type: string
    sql: ${TABLE}.poster_path ;;
    html: <img src="https://image.tmdb.org/t/p/w1280{{value}}" alt="{{title._value}}" width="100px"> ;;
  }

  dimension: poster_big {
    group_label: "Poster"
    type: string
    sql: ${poster} ;;
    html: <img src="https://image.tmdb.org/t/p/w1280{{value}}" alt="{{title._value}}" width="200px"> ;;
  }

  dimension: poster_gross {
    group_label: "Poster"
    type: string
    sql: ${poster} ;;
    html: <img src="https://image.tmdb.org/t/p/w1280{{value}}" alt="{{title._value}}" width="170px">
          <br>
          <p style="font-size:40px">{{revenue._rendered_value}}</p>
          ;;
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
    value_format_name: usd_0
    sql: ${TABLE}.revenue ;;
  }

  dimension: runtime {
    group_label: "Runtime"
    type: number
    sql: ${TABLE}.runtime ;;
  }

  dimension: runtime_tiered {
    group_label: "Runtime"
    type: tier
    style: integer
    tiers: [60,75,90,105,120,135,150,165,180]
    sql:  ${runtime} ;;
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
    link: {
      label: "Link to IMDB"
      url: "https://www.imdb.com/title/{{imdb_id._value}}"
      icon_url: "https://ia.media-imdb.com/images/M/MV5BMTczNjM0NDY0Ml5BMl5BcG5nXkFtZTgwMTk1MzQ2OTE@._V1_.png"
    }
    link: {
      label: "Link to TMDB"
#       url: "https://www.themoviedb.org/movie/{{links.tmdb_id._value}}"
      url: "https://www.themoviedb.org/movie/{{movie_id._value}}"
      icon_url: "https://www.themoviedb.org/assets/1/v4/logos/208x226-stacked-green-9484383bd9853615c113f020def5cbe27f6d08a84ff834f41371f223ebad4a3c.png"
    }
  }

  measure: movies_count {
    type: count
#     filters: {
#       field: movies.status
#       value: "Released"
#     }
    drill_fields:
    [
      release_year,
      title,
      movies.poster,
      actors.character_name,
      overview,
      genres.all_genres,
      ratings_summary.average_rating
    ]
  }

  set: release {
    fields:
    [
      release_date,
      release_month,
      release_quarter,
      release_raw,
      release_week,
      release_year
    ]
  }

  set: movies {
    fields:
    [
      movie_id,
      budget,
      imdb_id,
      original_language,
      original_title,
      overview,
      poster,
      poster_big,
      poster_gross,
      release*,
      revenue,
      runtime,
      runtime_tiered,
      status,
      tagline,
      title,
      movies_count
    ]
  }
}
