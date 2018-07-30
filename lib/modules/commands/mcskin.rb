module Granz::DiscordCommands
  module Mcskin
    extend Discordrb::Commands::CommandContainer
    command :mcskin, max_args: 1 do |event, uuid|
      begin
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.image = Discordrb::Webhooks::EmbedImage.new(url: "https://crafatar.com/skins/#{uuid}")
          embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: "https://crafatar.com/renders/head/#{uuid}?overlay")
          embed.title = "Here you go :"
          embed.description = "https://crafatar.com/skins/#{uuid}"
        end
      rescue
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = "Couldn't Find Skin"
        end
      end
    end
  end
end
