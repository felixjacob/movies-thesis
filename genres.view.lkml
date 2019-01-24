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
    group_label: "Genres"
    type: string
    sql: ${TABLE}.genre ;;
  }

  dimension: all_genres {
    group_label: "Genres"
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

  set: genres {
    fields:
    [
      genre,
      all_genres
    ]
  }
}

####################################################################################################

view: unique_genres {
  derived_table: {
    explore_source: genres {
      column: genre {}
    }
  }

  dimension: genre {}
}

####################################################################################################

view: genres_overlaps {
  derived_table: {
    explore_source: genres_join {
      column: all_genres {}
      column: movie_id {}
      column: genre1 { field: genre2.genre }
      column: genre2 { field: genre1.genre }
      filters: {
        field: genre1.genre
        value: "-NULL, -EMPTY"
      }
      filters: {
        field: genre2.genre
        value: "-NULL, -EMPTY"
      }
    }
  }

  dimension: all_genres {}

  dimension: movie_id {
    type: number
  }

  dimension: genre1 {
    type: string
  }

  dimension: genre2 {
    type: string
  }

  dimension: contains_both_genres {
    type: yesno
    sql: IF(${all_genres} LIKE CONCAT('%', genre1, '%')
    AND ${all_genres} LIKE CONCAT('%', genre2, '%')
    AND ${genre1} <> ${genre2}, TRUE, FALSE) ;;
  }

  measure: count {
    type: sum
    sql: IF(${contains_both_genres}, 1, 0) ;;
  }
}
