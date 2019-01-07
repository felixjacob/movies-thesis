view: genres {
  derived_table: {
    datagroup_trigger: movies_thesis_default_datagroup
    sql:
    WITH
      genres_split AS (
        SELECT
          id,
          SPLIT(REPLACE(REPLACE(`genres`, '[{', ''), '}]', ''), '}, {') AS genres_array
        FROM (SELECT DISTINCT id, `genres` FROM movies_data.movies_metadata)
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
        SELECT DISTINCT
          id,
          genre
        FROM genres, UNNEST(genres_array) AS genre
      )
      SELECT
        ROW_NUMBER() OVER () AS id,
        a.id                 AS movie_id,
        a.genre,
        ARRAY_TO_STRING(b.genres_array, ', ') AS genres,
        b.genres_array
      FROM genres_unnest a
      JOIN genres b
        ON a.id = b.id ;;
  }

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: movie_id {
    type: number
    sql: ${TABLE}.movie_id ;;
  }

  dimension: genre {
    type: string
    sql: ${TABLE}.genre ;;
  }

  dimension: genres {
    type: string
    sql: ${TABLE}.genres ;;
  }

  measure: count_distinct {
    type: count_distinct
    sql: ${TABLE}.id ;;
  }

  measure: count {
    type: count
  }
}
