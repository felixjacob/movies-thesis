view: cast {
  derived_table: {
    sql:
    SELECT
      id,
      CONCAT('{', `cast`, '}')                                  AS cast_json,
      JSON_EXTRACT(CONCAT('{', `cast`, '}'), '$.character')     AS character_name,
      JSON_EXTRACT(CONCAT('{', `cast`, '}'), '$.gender')        AS gender,
      JSON_EXTRACT(CONCAT('{', `cast`, '}'), '$.name')          AS actor_name,
      JSON_EXTRACT(CONCAT('{', `cast`, '}'), '$.profile_path')  AS picture
    FROM
      (SELECT
        id,
        SPLIT(REPLACE(REPLACE(`cast`, '[{', ''), ']}', ''), '}, {') AS cast_array
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
    sql: ${TABLE}.character_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender;;
  }

  dimension: actor_name {
    type: string
    sql: ${TABLE}.actor_name;;
  }

  dimension: picture {
    type: string
    sql: ${TABLE}.picture;;
  }
}
