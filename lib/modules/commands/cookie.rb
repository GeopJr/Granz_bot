module Granz::DiscordCommands
  module Cookie
    extend Discordrb::Commands::CommandContainer
    command :cookie do |event|
      begin
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = ":cookie:"
          embed.description = HTTP.get("http://www.yerkee.com/api/fortune").parse["fortune"]
        end
        event.message.react "🍪"
      rescue
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = "Error"
        end
      end
    end
  end
end
