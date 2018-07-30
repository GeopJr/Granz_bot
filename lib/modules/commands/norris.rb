module Granz::DiscordCommands
  module Norris
    extend Discordrb::Commands::CommandContainer
    command :norris do |event|
      begin
        url = URI.escape("http://api.icndb.com/jokes/random")
        parse = JSON.parse(RestClient.get(url))
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = parse["value"]["joke"]
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
