module Granz::DiscordCommands
  module Cat
    extend Discordrb::Commands::CommandContainer
    command :cat do |event|
      begin
        event.channel.send_embed do |embed|
          embed.image = Discordrb::Webhooks::EmbedImage.new(url: HTTP.get("http://shibe.online/api/cats?count=1").parse[0])
          embed.color = 0xffff00
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
