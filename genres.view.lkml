view: genres {
  derived_table: {
    datagroup_trigger: movies_thesis_default_datagroup
    sql:
    WITH
      genres_split AS (
        SELECT
          id,
          SPLIT(REPLACE(REPLACE(`genres`, '[{', ''), '}]', ''), '}, {') AS genres_array
        FROM movies_data.movies_metadata
      ),
      genres AS (
        SELECT
          id,
          ARRAY(SELECT
                  TRIM(REPLACE(IFNULL(JSON_EXTRACT(CONCAT('{', g, '}'), '$.name'), ''), '"', ''))
                FROM UNNEST(genres_array) AS g ORDER BY 1) AS genres_array
        FROM genres_split
      ),
      genres_unnest AS (
        SELECT
          id,
          genre
        FROM genres, UNNEST(genres_array) AS genre
      )
      SELECT
        a.id,
        a.genre,
        ARRAY_TO_STRING(b.genres_array, ', ') AS genres,
        b.genres_array
      FROM genres_unnest a
      JOIN genres b
        ON a.id = b.id ;;
  }

  dimension: pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: CONCAT(${movie_id}, ${genre}) ;;
  }

  dimension: movie_id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: genre {
    type: string
    sql: ${TABLE}.genre ;;
  }

  dimension: genres {
    type: string
    sql: ${TABLE}.genres ;;
  }

  measure: count {
    type: count_distinct
    sql: ${TABLE}.id ;;
  }
}
