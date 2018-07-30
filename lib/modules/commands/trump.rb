module Granz::DiscordCommands
  module Trump
    extend Discordrb::Commands::CommandContainer
    command :trump do |event|
      begin
        event.channel.send_embed do |embed|
          embed.title = HTTP.get("https://api.whatdoestrumpthink.com/api/v1/quotes/random").parse["message"]
          embed.colour = 0xffff00
        end
      rescue
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = "Error"
        end
      end
    end
  end
end
