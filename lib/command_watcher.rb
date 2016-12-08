require './lib/ingredient_checker.rb'

class CommandWatcher
  def self.parse(text)
    args = text.split(' ')
    if args[0].include?('/start')
      <<-MESSAGE
Hello, nice yo meet you!
Ask me about an ingredient by:
- simply writing an ingredient name in an single chat with me
- writing /check ingredient_name in a group chat
- type /help whenever you are confused
- type /info if you want to find out more
:)
      MESSAGE
    elsif args[0].include?('/help')
      <<-MESSAGE
/start     - startup message
/check :ingredient     - check an ingredient (in group chat)
:ingredient - check an ingredient (in single chat)
/info - info about this bot
/help      - this list of commands
      MESSAGE
    elsif args[0].include?('/info')
      <<-MESSAGE
Made by github.com/tpei

The code is open source and can be found here: https://github.com/TPei/VeganIngredientCheckerBot

If there are persisting problem with this bot or you'd like to request changes, open an issue here: https://github.com/TPei/VeganIngredientCheckerBot/issues/new
      MESSAGE
    elsif args[0].include?('/check')
      IngredientChecker.check(args[1..-1].join(' '))
    elsif args[0].start_with? '/'
      'Sorry, but I do not know that command'
    else
      IngredientChecker.check(text)
    end
  end
end
