module Granz::DiscordCommands
  module Server
    extend Discordrb::Commands::CommandContainer
    command :server do |event|
      begin
        event.channel.send_embed do |embed|
          embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: event.server.icon_url)
          embed.colour = 0xffff00
          embed.title = "**Server Info**"
          embed.add_field(name: "__Name__", value: "**#{event.server.name}**", inline: true)
          embed.add_field(name: "__ID__", value: "**#{event.server.id}**", inline: true)
          embed.add_field(name: "__Region__", value: "**#{event.server.region}**", inline: true)
          embed.add_field(name: "__Created at__", value: "**#{event.server.creation_time.getutc.asctime} (UTC)**", inline: true)
          embed.add_field(name: "__Owner__", value: "**#{event.server.owner.name}\##{event.server.owner.discrim}**")
          embed.add_field(name: "__Members__", value: "**#{event.server.members.count}**", inline: true)
          embed.add_field(name: "__Channels__", value: "**#{event.server.channels.count}**", inline: true)
          embed.add_field(name: "__Text Channels__", value: "**#{event.server.text_channels.count}**", inline: true)
          embed.add_field(name: "__Voice Channels__", value: "**#{event.server.voice_channels.count}**", inline: true)
          embed.add_field(name: "__Roles__", value: "**#{event.server.roles.count}**", inline: true)
          embed.add_field(name: "__Bans__", value: "**#{event.server.bans.count}**", inline: true)
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
