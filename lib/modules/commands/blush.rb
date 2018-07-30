module Granz::DiscordCommands
  module Blush
    extend Discordrb::Commands::CommandContainer
    command :blush do |event|
      begin
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.image = Discordrb::Webhooks::EmbedImage.new(url: "https://i.imgur.com/fIY6c7d.png")
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
