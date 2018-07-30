module Granz::DiscordCommands
  module Id
    extend Discordrb::Commands::CommandContainer
    command :id, min_args: 1, max_args: 1 do |event, user|
      user = user[2..-2]
      begin
        mentioned_user = $bot.user(user)
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = mentioned_user.mention.to_s
        end
      rescue StandardError
        user = user[1..-1]
        mentioned_user = $bot.user(user)
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = mentioned_user.mention.to_s
        end
      end
    end
  end
end
