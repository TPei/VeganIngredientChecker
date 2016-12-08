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
:)
      MESSAGE
    elsif args[0].include?('/help')
      <<-MESSAGE
/start     - startup message
/check :ingredient     - check an ingredient (in group chat)
:ingredient - check an ingredient (in single chat)
/help      - this list of commands
      MESSAGE
    elsif args[0].include?('/check')
      IngredientChecker.check(args[1])
    elsif args[0].start_with? '/'
      'Sorry, but I do not know that command'
    else
      IngredientChecker.check(args[0])
    end
  end
end
