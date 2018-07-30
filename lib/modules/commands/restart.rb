module Granz::DiscordCommands
  module Restart
    extend Discordrb::Commands::CommandContainer
    command :restart do |event|
      break unless event.user.id == Granz::CONFIG["$my_id"]
      $bot.stop
      exit
    end
  end
end
