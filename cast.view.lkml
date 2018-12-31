view: cast {
  derived_table: {
    datagroup_trigger: movies_thesis_default_datagroup
    sql:
    SELECT
      id,
      IF(`cast` <> '[]', CONCAT('{', `cast`, '}'), NULL) AS cast_json
    FROM
      (SELECT
        id,
        SPLIT(REPLACE(REPLACE(`cast`, '[{', ''), '}]', ''), '}, {') AS cast_array
        FROM movies_data.credits), UNNEST(cast_array) AS `cast` ;;
  }

  dimension: movie_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: cast_json {
    type: string
    sql: ${TABLE}.cast_json ;;
  }

  dimension: character_name {
    type: string
    sql: TRIM(REPLACE(JSON_EXTRACT(${TABLE}.cast_json, '$.character'), '"', '')) ;;
  }

  dimension: gender {
    type: string
    sql: JSON_EXTRACT(${TABLE}.cast_json, '$.gender') ;;
  }

  dimension: actor_name {
    type: string
    sql: TRIM(REPLACE(JSON_EXTRACT(${TABLE}.cast_json, '$.name'), '"', '')) ;;
  }

  dimension: picture {
    type: string
    sql: TRIM(REPLACE(JSON_EXTRACT(${TABLE}.cast_json, '$.profile_path'), '"', '')) ;;
  }
}
