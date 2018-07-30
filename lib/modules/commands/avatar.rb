module Granz::DiscordCommands
  module Avatar
    extend Discordrb::Commands::CommandContainer
    command :avatar, min_args: 1, max_args: 1 do |event, user|
      user = user[2..-2]
      begin
        mentioned_user = $bot.user(user)
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.image = Discordrb::Webhooks::EmbedImage.new(url: "#{mentioned_user.avatar_url}?size=1024")
        end
      rescue StandardError
        user = user[1..-1]
        mentioned_user = $bot.user(user)
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.image = Discordrb::Webhooks::EmbedImage.new(url: "#{mentioned_user.avatar_url}?size=1024")
        end
      end
    end
  end
end
