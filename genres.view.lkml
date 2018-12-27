view: genres {
  derived_table: {
    sql:
    SELECT
      id,
      IF(`genre` <> '[]', CONCAT('{', `genre`, '}'), NULL) AS genre_json
    FROM
      (SELECT
        id,
        SPLIT(REPLACE(REPLACE(`genres`, '[{', ''), '}]', ''), '}, {') AS genres_array
        FROM movies_data.movies_metadata), UNNEST(genres_array) AS `genre` ;;
  }

  dimension: movie_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: genre_json {
    type: string
    sql: ${TABLE}.genre_json ;;
  }

  dimension: genre {
    type: string
    sql: TRIM(REPLACE(JSON_EXTRACT(${TABLE}.genre_json, '$.name'), '"', '')) ;;
  }

  measure: genres {
    type: string
    sql: TRIM(STRING_AGG(CONCAT(' ', ${genre}) ORDER BY ${genre})) ;;
  }
}
