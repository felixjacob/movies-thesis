connection: "thesis_bq"

# include all the views
include: "*.view"

datagroup: movies_thesis_default_datagroup {
  sql_trigger: SELECT MAX(id) FROM movies_data.movies_metadata ;;
}

persist_with: movies_thesis_default_datagroup

####################################################################################################
# ACTORS EXPLORE
####################################################################################################

explore: actors {
  from: cast
  sql_always_where:
    ${actors.actor_name} IS NOT NULL
    AND ${movies.status} = 'Released'
    AND ${genres.all_genres} NOT LIKE '%Documentary%'
    AND ${genres.all_genres} NOT LIKE '%TV Movie%'
    AND ${genres.all_genres} NOT LIKE '%Foreign%'
    AND ${movies.original_language} = 'EN' ;;
  fields: [ALL_FIELDS*, -actors.movie_id]
  join: actors_facts {
    view_label: "Actors Facts"
    sql_on: ${actors.actor_id} = ${actors_facts.actor_id} ;;
    type: inner
    relationship: many_to_one
    fields: [actors_facts.facts*]
  }

  join: actors_ranks_final {
    view_label: "Ranks"
    sql_on: ${actors.actor_id} = ${actors_ranks_final.actor_id} ;;
    type: left_outer
    relationship: many_to_one
    fields: [actors_ranks_final.ranks*]
  }

  join: movies {
    view_label: "Movies Details"
    sql_on: ${actors.movie_id} = ${movies.movie_id} ;;
    type: inner
    relationship: many_to_one
    fields: [movies.movies*, movies.years_from_start_of_career]
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

####################################################################################################
# DIRECTORS EXPLORE
####################################################################################################

explore: directors {
  from: crew
  sql_always_where:
  ${directors.job} = 'Director'
  AND ${movies.status} = 'Released'
  AND ${genres.all_genres} NOT LIKE '%Documentary%'
  AND ${genres.all_genres} NOT LIKE '%TV Movie%'
  AND ${genres.all_genres} NOT LIKE '%Foreign%'
  AND ${movies.original_language} = 'EN' ;;
  fields: [ALL_FIELDS*, -directors.movie_id]
  join: movies {
    view_label: "Movies Details"
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

####################################################################################################
# MOVIES EXPLORE
####################################################################################################

explore: movies {
  sql_always_where:
  ${movies.status} = 'Released'
  AND ${genres.all_genres} NOT LIKE '%Documentary%'
  AND ${genres.all_genres} NOT LIKE '%TV Movie%'
  AND ${genres.all_genres} NOT LIKE '%Foreign%'
  AND ${movies.original_language} = 'EN' ;;
  fields: [ALL_FIELDS*, -movies.years_from_start_of_career]
  join: genres {
    view_label: "Movies"
    sql_on: ${movies.movie_id} = ${genres.movie_id} ;;
    type: inner
    relationship: one_to_many
    fields: [genres.genres*]
  }

  join: keywords {
    sql_on: ${movies.movie_id} = ${keywords.movie_id} ;;
    type: inner
    relationship: one_to_many
    fields: [keywords.keywords*]
  }

  join: ratings_summary {
    view_label: "Ratings"
    sql_on: ${movies.movie_id} = ${ratings_summary.movie_id} ;;
    type: inner
    relationship: one_to_many
    fields: [ratings_summary.ratings*]
  }
}

####################################################################################################
# GENRES OVERLAP EXPLORE
####################################################################################################

explore: genres { hidden: yes }

explore: genres_join {
  hidden: yes
  from: genres
  sql_always_where:
  ${movies.status} = 'Released'
  AND ${genres_join.all_genres} NOT LIKE '%Documentary%'
  AND ${genres_join.all_genres} NOT LIKE '%TV Movie%'
  AND ${genres_join.all_genres} NOT LIKE '%Foreign%'
  AND ${movies.original_language} = 'EN' ;;
  fields: [genres_join.movie_id, genres_join.all_genres, genre1.genre, genre2.genre]
  join: genre1 {
    from: unique_genres
    type: cross
    relationship: many_to_many
    fields: [genre1.genre]
  }

  join: genre2 {
    from: unique_genres
    type: cross
    relationship: many_to_many
    fields: [genre2.genre]
  }

  join: movies {
    view_label: "Movies Details"
    sql_on: ${genres_join.movie_id} = ${movies.movie_id} ;;
    type: inner
    relationship: many_to_one
    fields: [movies.original_language, movies.status]
  }
}

explore: genres_overlaps {}

####################################################################################################
# OTHER EXPLORES
####################################################################################################

# explore: actors_facts { hidden: yes }

explore: actors_ranks { hidden: yes }

explore: actors_ranks_final { hidden: yes }

# explore: crew { hidden: yes }

# explore: keywords { hidden: yes }

# explore: links { hidden: yes }

explore: ratings { hidden: yes }

# explore: ratings_summary { hidden: yes }
