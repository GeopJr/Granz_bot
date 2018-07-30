module Granz::DiscordCommands
  module Neko
    extend Discordrb::Commands::CommandContainer
    command :neko do |event|
      next event.channel.send_embed do |embed|; embed.title = "I'm sorry. I can't do that because this is a SFW channel."; embed.color = 0xffff00; embed.image = Discordrb::Webhooks::EmbedImage.new(url: "https://i.imgur.com/yVs6TqV.gif"); end unless event.channel.nsfw
      begin
        event.channel.send_embed do |embed|
          embed.image = Discordrb::Webhooks::EmbedImage.new(url: HTTP.get("https://nekos.life/api/lewd/neko").parse["neko"])
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
