module Granz::DiscordCommands
  module Kick
    extend Discordrb::Commands::CommandContainer
    command :kick, min_args: 1, max_args: 1, required_permissions: [:kick_members] do |event, user|
      begin
        event.server.kick(event.bot.parse_mention(user))
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = "Kicked"
          embed.description = "#{user}"
        end
      rescue
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = "I can't do that for some reason"
          embed.description = "Probably I don't have enough permissions or this user has a higher role than me"
        end
      end
    end
  end
end
