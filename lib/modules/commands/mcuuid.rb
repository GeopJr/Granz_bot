module Granz::DiscordCommands
  module Mcuuid
    extend Discordrb::Commands::CommandContainer
    command :mcuuid, max_args: 1 do |event, username|
      begin
        url = URI.escape("https://api.mojang.com/users/profiles/minecraft/#{username}")
        parse = JSON.parse(RestClient.get(url))
        name = parse["name"]
        uuid = parse["id"]
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: "https://crafatar.com/renders/head/#{uuid}?overlay")
          embed.title = "#{name}'s UUID is :"
          embed.description = "#{uuid}"
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
