module Granz::DiscordCommands
  module Bara
    extend Discordrb::Commands::CommandContainer
    command :bara do |event|
      next event.channel.send_embed do |embed|; embed.title = "I'm sorry. I can't do that because this is a SFW channel."; embed.color = 0xffff00; embed.image = Discordrb::Webhooks::EmbedImage.new(url: "https://i.imgur.com/yVs6TqV.gif"); end unless event.channel.nsfw
      begin
        event.channel.send_embed do |embed|
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "https://barapi.geopjr.xyz/")
          embed.image = Discordrb::Webhooks::EmbedImage.new(url: HTTP.get("https://barapi.000webhostapp.com/api/random.php").parse[0])
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
