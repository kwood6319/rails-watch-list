require "json"
require "open-uri"

puts "Let's clean up..."
Movie.destroy_all
puts "All clean! #{Movie.count} movies remaining"

puts "Let's find some movies"

url = "http://tmdb.lewagon.com/movie/top_rated"

puts "Importing movie..."
movies = JSON.parse(URI.open(url).read)["results"]
movies.each do |movie|
  puts "Creating #{movie["title"]}"
  base_poster_url = "https://image.tmdb.org/t/p/original"
  Movie.create(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: "#{base_poster_url}#{movie["poster_path"]}",
    rating: movie["vote_average"]
  )
end
puts "Movies created"
