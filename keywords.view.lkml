view: keywords {
  derived_table: {
    datagroup_trigger: movies_thesis_default_datagroup
    sql:
    WITH
      keywords AS (
        SELECT
          id,
          IF(k <> '[]', CONCAT('{', k, '}'), NULL) AS keyword_json
        FROM
          (SELECT
            id,
            SPLIT(REPLACE(REPLACE(k.keywords, '[{', ''), '}]', ''), '}, {') AS keywords_array
            FROM movies_data.keywords AS k), UNNEST(keywords_array) AS k)
    SELECT DISTINCT
      ROW_NUMBER() OVER () AS id,
      a.id                 AS movie_id,
      keyword_json,
      --LOWER(TRIM(REPLACE(JSON_EXTRACT(keyword_json, '$.id'), '"', ''))) AS keyword_id,
      LOWER(TRIM(REPLACE(JSON_EXTRACT(keyword_json, '$.name'), '"', ''))) AS keyword
    FROM keywords ;;
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

#   dimension: keyword_id {
#     type: number
#     sql: ${TABLE}.keyword_id ;;
#   }

#   dimension: keyword_json {
#     type: string
#     sql: ${TABLE}.keyword_json ;;
#   }

  dimension: keyword {
    type: string
    sql: ${TABLE}.keyword ;;
  }

  measure: count {
    type: count
  }
}
