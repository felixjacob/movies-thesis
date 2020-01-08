view: crew {
  derived_table: {
    datagroup_trigger: movies_thesis_default_datagroup
    sql:
    WITH
      crew_details AS (
        SELECT
          id,
          IF(c <> '[]', CONCAT('{', c, '}'), NULL) AS crew_json
        FROM
          (SELECT
            id,
            SPLIT(REPLACE(REPLACE(`crew`, '[{', ''), '}]', ''), '}, {') AS crew_array
            FROM movies_data.credits), UNNEST(crew_array) AS c),
      crew_formatted AS (
        SELECT DISTINCT
          id                                                                      AS movie_id,
          --crew_json,
          TRIM(REPLACE(JSON_EXTRACT(crew_json, '$.name'), '"', ''))               AS name,
          CAST(JSON_EXTRACT(crew_json, '$.id') AS INT64)                          AS person_id,
          TRIM(REPLACE(JSON_EXTRACT(crew_json, '$.department'), '"', ''))         AS department,
          TRIM(REPLACE(JSON_EXTRACT(crew_json, '$.job'), '"', ''))                AS job,
          NULLIF(CAST(JSON_EXTRACT(crew_json, '$.gender') AS INT64), 0)           AS gender,
          TRIM(REPLACE(JSON_EXTRACT(crew_json, '$.profile_path'), '"', ''))       AS picture
        FROM crew_details)

    SELECT
      ROW_NUMBER() OVER () AS id,
      *
    FROM crew_formatted ;;
  }

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

  dimension: person_id {
    type: number
    sql: ${TABLE}.person_id ;;
  }

#   dimension: crew_json {
#     type: string
#     sql: ${TABLE}.crew_json ;;
#   }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: job {
    type: string
    sql: ${TABLE}.job ;;
  }

  dimension: gender {
    type: number
    sql: ${TABLE}.gender ;;
  }

  dimension: name {
    group_label: "Name"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: name_big {
    group_label: "Name"
    type: string
    sql: ${name} ;;
    html: <b><p style="font-size:60px">{{value}}</p></b> ;;
  }

  dimension: picture_big {
    group_label: "Picture"
    type: string
    sql: ${TABLE}.picture ;;
    html: <img src="https://image.tmdb.org/t/p/w1280/{{value}}" alt="{{name._value}}" width="300px"> ;;
  }

  dimension: picture_small {
    group_label: "Picture"
    type: string
    sql: ${TABLE}.picture ;;
    html: <img src="https://image.tmdb.org/t/p/w1280/{{value}}" alt="{{name._value}}" width="100px"> ;;
  }

  set: crew {
    fields:
    [
      person_id,
      name,
      name_big,
      gender,
      job,
      department,
      picture_big,
      picture_small
    ]
  }
}
