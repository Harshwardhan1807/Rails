class OmdbService
  include HTTParty
  base_uri "http://www.omdbapi.com"

  def self.search_movies(query, page = 1)
    api_key = ENV["API_KEY"]

    response = get("/", query: {
                          s: query,
                          page: page,
                          apikey: api_key,
                        })

    response["Search"] || []
  end

  def self.fetch_movie_by_id(imdb_id)
    api_key = ENV["API_KEY"]

    response = get("/", query: {
                          i: imdb_id,
                          apikey: api_key,
                        })

    return nil if response["Response"] == "False"

    {
      title: response["Title"],
      description: response["Plot"],
      duration: response["Runtime"].to_i,
      poster_url: response["Poster"] == "N/A" ? nil : response["Poster"],
      rating: response["imdbRating"].to_f,
      imdb_id: response["imdbID"],
    }
  end
end
