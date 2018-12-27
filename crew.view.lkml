view: crew {
  derived_table: {
    sql:
    SELECT
      id,
      IF(`crew` <> '[]', CONCAT('{', `crew`, '}'), NULL)            AS crew_json
      --JSON_EXTRACT(CONCAT('{', `crew`, '}'), '$.department')    AS department,
      --JSON_EXTRACT(CONCAT('{', `crew`, '}'), '$.job')           AS job,
      --JSON_EXTRACT(CONCAT('{', `crew`, '}'), '$.gender')        AS gender,
      --JSON_EXTRACT(CONCAT('{', `crew`, '}'), '$.name')          AS name,
      --JSON_EXTRACT(CONCAT('{', `crew`, '}'), '$.profile_path')  AS picture
    FROM
      (SELECT
        id,
        SPLIT(REPLACE(REPLACE(`crew`, '[{', ''), ']}', ''), '}, {') AS crew_array
        FROM movies_data.credits), UNNEST(crew_array) AS `crew` ;;
  }

  dimension: movie_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: crew_json {
    type: string
    sql: ${TABLE}.crew_json ;;
  }

  dimension: department {
    type: string
    sql: TRIM(REPLACE(JSON_EXTRACT(${TABLE}.crew_json, '$.department'), '"', '')) ;;
  }

  dimension: job {
    type: string
    sql: TRIM(REPLACE(JSON_EXTRACT(${TABLE}.crew_json, '$.job'), '"', '')) ;;
  }

  dimension: gender {
    type: string
    sql: JSON_EXTRACT(${TABLE}.crew_json, '$.gender') ;;
  }

  dimension: name {
    type: string
    sql: TRIM(REPLACE(JSON_EXTRACT(${TABLE}.crew_json, '$.name'), '"', '')) ;;
  }

  dimension: picture {
    type: string
    sql: TRIM(REPLACE(JSON_EXTRACT(${TABLE}.crew_json, '$.profile_path'), '"', '')) ;;
  }
}
