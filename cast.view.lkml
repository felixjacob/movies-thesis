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
            FROM movies_data.credits), UNNEST(cast_array) AS c)
    SELECT DISTINCT
      id,
      cast_json,
      TRIM(REPLACE(JSON_EXTRACT(cast_json, '$.credit_id'), '"', ''))     AS cast_id,
      TRIM(REPLACE(JSON_EXTRACT(cast_json, '$.character'), '"', ''))     AS character_name,
      JSON_EXTRACT(cast_json, '$.gender')                                AS gender,
      TRIM(REPLACE(JSON_EXTRACT(cast_json, '$.name'), '"', ''))          AS actor_name,
      TRIM(REPLACE(JSON_EXTRACT(cast_json, '$.profile_path'), '"', ''))  AS picture
    FROM cast_details ;;
  }

  dimension: cast_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.cast_id;;
  }

  dimension: movie_id {
    type: number
    sql: ${TABLE}.id ;;
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
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: actor_name {
    type: string
    sql: ${TABLE}.actor_name ;;
  }

  dimension: picture {
    type: string
    sql: ${TABLE}.picture ;;
  }

  measure: count {
    type: count
  }
}
