module Granz::DiscordCommands
  module Ping
    extend Discordrb::Commands::CommandContainer
    command :ping do |event|
      begin
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = ":ping_pong: Pong! (#{Time.now - event.timestamp} sec.)"
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
