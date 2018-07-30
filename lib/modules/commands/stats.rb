module Granz::DiscordCommands
  module Stats
    extend Discordrb::Commands::CommandContainer
    command :stats do |event|
      begin
        members = 0
        event.bot.servers.each do |x, y|
          members = members + y.member_count
        end
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = "Stats"
          embed.description = "Currently I'm on <:discord:314003252830011395> **#{event.bot.servers.size} servers** with a total user count of <:online:313956277808005120> **#{members} users** in **#{event.bot.servers.collect { |x, y| y.channels.size }.inject(0, &:+)} channels**!"
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
