require 'net/http'
require 'json'

URL = 'http://www.veganpeace.com/ingredients/ingredients.htm'

class IngredientChecker
  def self.check(ingredient)
    url = URI.parse(URL)
    req = Net::HTTP::Get.new(url.to_s)

    begin
      res = Net::HTTP.start(url.host, url.port) do |http|
        http.request(req)
      end

      list = res.body.split("\n")
      #list.map!(&:downcase)

      matches = list.select { |line| line.downcase.include? ingredient.downcase }
      matches.sort! { |a, b| a.downcase.index(ingredient.downcase) <=> b.downcase.index(ingredient.downcase) }

      match = matches[0]

      if match.include? '(A)'
        "Hey, it looks like #{ingredient.downcase} is animal-based... Sorry about that :("
      elsif match.include? '(V)'
        "Hey, it looks like #{ingredient.downcase} is vegan... Yay! Go, have at it! :D"
      elsif match.include? '(B)'
        "Hmm, this one is tricky. #{ingredient.capitalize} exists in both animal and vegan versions... :S"
      else
        "Hmm, I'm confused, I found the ingredient, but no info on whether it's vegan or not"
      end
    rescue Exception
      'Sorry, I can\'t get a response from the veganpeace.com right now. Please try again later'
    end
  end
end
