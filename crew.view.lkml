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
          id                                                                 AS movie_id,
          --crew_json,
          --TRIM(REPLACE(JSON_EXTRACT(crew_json, '$.credit_id'), '"', ''))     AS crew_id,
          TRIM(REPLACE(JSON_EXTRACT(crew_json, '$.department'), '"', ''))    AS department,
          TRIM(REPLACE(JSON_EXTRACT(crew_json, '$.job'), '"', ''))           AS job,
          NULLIF(CAST(JSON_EXTRACT(crew_json, '$.gender') AS INT64), 0)      AS gender,
          TRIM(REPLACE(JSON_EXTRACT(crew_json, '$.name'), '"', ''))          AS name,
          TRIM(REPLACE(JSON_EXTRACT(crew_json, '$.profile_path'), '"', ''))  AS picture
        FROM crew_details

    SELECT
      ROW_NUMBER() OVER () AS id,
      *
    FROM crew_formatted ;;
  }

#   dimension: crew_id {
#     primary_key: yes
#     type: string
#     sql: ${TABLE}.crew_id;;
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
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: picture {
    type: string
    sql: ${TABLE}.picture ;;
  }

  measure: count {
    type: count
  }
}
