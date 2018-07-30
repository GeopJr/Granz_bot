module Granz::DiscordCommands
  module Coffee
    extend Discordrb::Commands::CommandContainer
    command :coffee do |event|
      begin
        event.channel.send_embed do |embed|
          embed.image = Discordrb::Webhooks::EmbedImage.new(url: HTTP.get("https://coffee.alexflipnote.xyz/random.json").parse["file"])
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
