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
            FROM movies_data.credits), UNNEST(crew_array) AS c)
    SELECT
      id,
      crew_json,
      TRIM(REPLACE(JSON_EXTRACT(crew_json, '$.department'), '"', ''))    AS department,
      TRIM(REPLACE(JSON_EXTRACT(crew_json, '$.job'), '"', ''))           AS job,
      JSON_EXTRACT(crew_json, '$.gender')                                AS gender,
      TRIM(REPLACE(JSON_EXTRACT(crew_json, '$.name'), '"', ''))          AS name,
      TRIM(REPLACE(JSON_EXTRACT(crew_json, '$.profile_path'), '"', ''))  AS picture
    FROM crew_details ;;
  }

  dimension: movie_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
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
    type: string
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
}
