view: cast {
  derived_table: {
    datagroup_trigger: movies_thesis_default_datagroup
    sql:
    WITH
      cast_details AS (
        SELECT
          id,
          IF(c <> '[]', CONCAT('{', c, '}'), NULL) AS cast_json
        FROM
          (SELECT
            id,
            SPLIT(REPLACE(REPLACE(`cast`, '[{', ''), '}]', ''), '}, {') AS cast_array
            FROM movies_data.credits), UNNEST(cast_array) AS c),
      cast_formatted AS (
        SELECT DISTINCT
          id                                                                      AS movie_id,
          --cast_json,
          TRIM(REPLACE(JSON_EXTRACT(cast_json, '$.name'), '"', ''))               AS actor_name,
          CAST(JSON_EXTRACT(cast_json, '$.id') AS INT64)                          AS actor_id,
          CAST(JSON_EXTRACT(cast_json, '$.order') AS INT64)                       AS cast_order,
          NULLIF(CAST(JSON_EXTRACT(cast_json, '$.gender') AS INT64), 0)           AS gender,
          TRIM(REPLACE(JSON_EXTRACT(cast_json, '$.profile_path'), '"', ''))       AS picture,
          TRIM(REPLACE(JSON_EXTRACT(cast_json, '$.character'), '"', ''))          AS character_name
        FROM cast_details)

    SELECT
      ROW_NUMBER() OVER () AS id,
      IF(cast_order < 5, 'Main', 'Secondary') AS role_type,
      *
    FROM cast_formatted ;;
  }

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: actor_id {
    type: number
    sql: ${TABLE}.actor_id ;;
  }

  dimension: movie_id {
    type: number
    sql: ${TABLE}.movie_id ;;
  }

#   dimension: cast_json {
#     type: string
#     sql: ${TABLE}.cast_json ;;
#   }

  dimension: cast_order {
    type: number
    sql: ${TABLE}.cast_order ;;
  }

  dimension: character_name {
    view_label: "Character"
    type: string
    sql: ${TABLE}.character_name ;;
  }

  dimension: gender {
    type: number
    sql: ${TABLE}.gender ;;
  }

  dimension: actor_name {
    group_label: "Actor Name"
    type: string
    sql: ${TABLE}.actor_name ;;
    link: {
      label: "Link to TMDB"
      url: "https://www.themoviedb.org/person/{{actor_id._value}}"
      icon_url: "https://www.themoviedb.org/assets/1/v4/logos/208x226-stacked-green-9484383bd9853615c113f020def5cbe27f6d08a84ff834f41371f223ebad4a3c.png"
    }
    link: {
      label: "Actors Dashboard"
      url: "/dashboards/3?Name={{value}}&Id={{actor_id._value}}"
      icon_url: "https://looker.com/favicon.ico"
    }
  }

  dimension: actor_name_big {
    group_label: "Actor Name"
    type: string
    sql: ${actor_name} ;;
    html: <b><p style="font-size:60px">{{value}}</p></b> ;;
  }

  dimension: picture_big {
    group_label: "Picture"
    type: string
    sql: ${TABLE}.picture ;;
    html: <img src="https://image.tmdb.org/t/p/w1280/{{value}}" alt="{{actor_name._value}}" width="300px"> ;;
  }

  dimension: picture_small {
    group_label: "Picture"
    type: string
    sql: ${TABLE}.picture ;;
    html: <img src="https://image.tmdb.org/t/p/w1280/{{value}}" alt="{{actor_name._value}}" width="100px"> ;;
  }

  dimension: role_type {
    view_label: "Character"
    type: string
    sql: ${TABLE}.role_type ;;
  }

  dimension: is_voice {
    view_label: "Character"
    type: yesno
    sql: LOWER(${character_name}) LIKE '%voice%' ;;
  }

  measure: main_roles_count {
    type: count_distinct
    sql: ${id} ;;
    filters: {
      field: role_type
      value: "Main"
    }
    drill_fields: [drill*]
  }

  measure: secondary_roles_count {
    type: count_distinct
    sql: ${id} ;;
    filters: {
      field: role_type
      value: "Secondary"
    }
    drill_fields: [drill*]
  }

  measure: first_movie_year {
    hidden: yes
    type: min
    sql: ${movies.release_year} ;;
#     filters: {
#       field: role_type
#       value: "Main"
#     }
  }

  measure: last_movie_year {
    hidden: yes
    type: max
    sql: ${movies.release_year} ;;
#     filters: {
#       field: role_type
#       value: "Main"
#     }
  }

  set: drill {
    fields: [
      movies.release_year,
      movies.title,
      movies.poster,
      character_name,
      movies.overview,
      genres.all_genres,
      ratings_summary.average_rating
    ]
  }

  set: cast {
    fields:
    [
      actor_id,
      actor_name,
      actor_name_big,
      gender,
      character_name,
      picture_big,
      picture_small,
      main_roles_count,
      secondary_roles_count
    ]
  }
}
