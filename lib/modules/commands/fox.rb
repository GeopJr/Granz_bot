module Granz::DiscordCommands
  module Fox
    extend Discordrb::Commands::CommandContainer
    command :fox do |event|
      begin
        event.channel.send_embed do |embed|
          embed.image = Discordrb::Webhooks::EmbedImage.new(url: HTTP.get("https://randomfox.ca/floof/").parse["image"])
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
