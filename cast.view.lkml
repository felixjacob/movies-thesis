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
          --TRIM(REPLACE(JSON_EXTRACT(cast_json, '$.credit_id'), '"', ''))          AS cast_id,
          TRIM(REPLACE(JSON_EXTRACT(cast_json, '$.name'), '"', ''))               AS actor_name,
          MAX(NULLIF(CAST(JSON_EXTRACT(cast_json, '$.gender') AS INT64), 0))      AS gender,
          MAX(TRIM(REPLACE(JSON_EXTRACT(cast_json, '$.profile_path'), '"', '')))  AS picture,
          MAX(TRIM(REPLACE(JSON_EXTRACT(cast_json, '$.character'), '"', '')))     AS character_name
        FROM cast_details
        GROUP BY 1, 2)

    SELECT
      ROW_NUMBER() OVER () AS id,
      *
    FROM cast_formatted ;;
  }

#   dimension: cast_id {
#     primary_key: yes
#     type: string
#     sql: ${TABLE}.cast_id;;
#   }

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: movie_id {
    type: number
    sql: ${TABLE}.movie_id ;;
  }

#   dimension: cast_json {
#     type: string
#     sql: ${TABLE}.cast_json ;;
#   }

  dimension: character_name {
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

  set: cast {
    fields:
    [
      actor_name,
      actor_name_big,
      gender,
      character_name,
      picture_big,
      picture_small
    ]
  }
}
