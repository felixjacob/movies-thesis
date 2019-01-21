connection: "thesis_bq"

# include all the views
include: "*.view"

datagroup: movies_thesis_default_datagroup {
  sql_trigger: SELECT MAX(id) FROM movies_data.movies_metadata ;;
}

persist_with: movies_thesis_default_datagroup

###########################
# ACTORS EXPLORE
###########################

explore: actors {
  from: cast
  sql_always_where:
    ${actors.actor_name} IS NOT NULL
    AND ${movies.status} = 'Released'
    AND ${genres.all_genres} NOT LIKE '%Documentary%'
    AND ${genres.all_genres} NOT LIKE '%TV Movie%'
    AND ${movies.original_language} = 'EN' ;;
  fields:
  [ALL_FIELDS*, -actors.movie_id]
#   [actors.cast*, actor_facts.total_movies_count,
#     movies.movies*, genres.genres*, ratings_summary.ratings*]
  join: actor_facts {
    view_label: "Actors"
    sql_on: ${actors.actor_name} = ${actor_facts.actor_name} ;;
    type: inner
    relationship: one_to_one
    fields: [actor_facts.total_movies_count]
  }

  join: movies {
    view_label: "Movies Details"
#     sql_where: ${movies.status} = 'Released' ;;
    sql_on: ${actors.movie_id} = ${movies.movie_id} ;;
    type: inner
    relationship: many_to_one
    fields: [movies.movies*]
  }

  join: genres {
    view_label: "Movies Details"
    sql_on: ${actors.movie_id} = ${genres.movie_id} ;;
    type: inner
    relationship: many_to_many
    fields: [genres.genres*]
  }

  join: ratings_summary {
    view_label: "Ratings"
    sql_on: ${actors.movie_id} = ${ratings_summary.movie_id} ;;
    type: inner
    relationship: many_to_many
    fields: [ratings_summary.ratings*]
  }
}

###########################
# DIRECTORS EXPLORE
###########################

explore: directors {
  from: crew
  sql_always_where:
  ${directors.job} = 'Director'
  AND ${movies.status} = 'Released'
  AND ${genres.all_genres} NOT LIKE '%Documentary%'
  AND ${genres.all_genres} NOT LIKE '%TV Movie%'
  AND ${movies.original_language} = 'EN' ;;
  fields:
  [ALL_FIELDS*, -directors.movie_id]
  join: movies {
    view_label: "Movies Details"
#     sql_where: ${movies.status} = 'Released' ;;
    sql_on: ${directors.movie_id} = ${movies.movie_id} ;;
    type: inner
    relationship: many_to_one
    fields: [movies.movies*]
  }

  join: genres {
    view_label: "Movies Details"
    sql_on: ${directors.movie_id} = ${genres.movie_id} ;;
    type: inner
    relationship: many_to_many
    fields: [genres.genres*]
  }

  join: ratings_summary {
    view_label: "Ratings"
    sql_on: ${directors.movie_id} = ${ratings_summary.movie_id} ;;
    type: inner
    relationship: many_to_many
    fields: [ratings_summary.ratings*]
  }
}

###########################
# MOVIES EXPLORE
###########################

explore: movies {
  sql_always_where:
  ${movies.status} = 'Released'
  AND ${genres.all_genres} NOT LIKE '%Documentary%'
  AND ${genres.all_genres} NOT LIKE '%TV Movie%'
  AND ${movies.original_language} = 'EN' ;;
  join: genres {
    sql_on: ${movies.movie_id} = ${genres.movie_id} ;;
    type: inner
    relationship: one_to_many
  }

  # join: cast {
  #   sql_on: ${movies.movie_id} = ${cast.movie_id} ;;
  #   type: inner
  #   relationship: one_to_many
  # }

  # join: crew {
  #   sql_on: ${movies.movie_id} = ${crew.movie_id} ;;
  #   type: inner
  #   relationship: one_to_many
  # }

  join: keywords {
    sql_on: ${movies.movie_id} = ${keywords.movie_id} ;;
    type: inner
    relationship: one_to_many
  }

  join: ratings_summary {
    sql_on: ${movies.movie_id} = ${ratings_summary.movie_id} ;;
    type: inner
    relationship: one_to_many
  }
}

###########################
# HIDDEN EXPLORES (DEBUG)
###########################

explore: actor_facts { hidden: yes }

explore: crew { hidden: yes }

explore: genres { hidden: yes }

explore: keywords { hidden: yes }

explore: links { hidden: yes }

explore: ratings { hidden: yes }

explore: ratings_summary { hidden: yes }
