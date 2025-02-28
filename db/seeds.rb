# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'json'
require 'open-uri'

movie_list = JSON.parse(URI.parse('https://tmdb.lewagon.com/movie/top_rated').read)

Movie.destroy_all

10.times do |t|
  Movie.create(title: movie_list["results"][t]["original_title"], overview: movie_list["results"][t]["overview"], rating: movie_list["results"][t]["vote_average"],poster_url: "https://image.tmdb.org/t/p/original#{movie_list["results"][t]["poster_path"]}")
end

puts "Finished! Created #{Movie.count} movies."

# poster_url: "https://image.tmdb.org/t/p/original#{movie_list["results"]["poster_path"]}
# rating: movie_list["results"]["1"]["vote_average"]
