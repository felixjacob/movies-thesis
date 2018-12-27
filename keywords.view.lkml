view: keywords {
  # sql_table_name: movies_data.keywords ;;
  derived_table: {
    sql:
    SELECT
      id,
      IF(`keyword` <> '[]', CONCAT('{', `keyword`, '}'), NULL) AS keyword_json
    FROM
      (SELECT
        id,
        SPLIT(REPLACE(REPLACE(k.keywords, '[{', ''), '}]', ''), '}, {') AS keywords_array
        FROM movies_data.keywords AS k), UNNEST(keywords_array) AS `keyword` ;;
  }

  dimension: movie_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: keyword_json {
    type: string
    sql: ${TABLE}.keyword_json ;;
  }

  dimension: keyword {
    type: string
    sql: LOWER(TRIM(REPLACE(JSON_EXTRACT(${TABLE}.keyword_json, '$.name'), '"', ''))) ;;
  }
}
