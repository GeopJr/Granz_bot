module Granz::DiscordCommands
  module Kiss
    extend Discordrb::Commands::CommandContainer
    command :kiss, min_args: 1, max_args: 1 do |event, user|
      user = user[2..-2]
      begin
        mentioned_user = $bot.user(user)
        if mentioned_user.mention == event.user.mention
          event.channel.send_embed do |embed|
            embed.colour = 0xffff00
            embed.description = "#{event.user.mention} Sorry , you can't kiss yourself :cry:. But I can kiss you if you want :blush:"
          end
        else
          event.channel.send_embed do |embed|
            embed.colour = 0xffff00
            embed.description = "#{mentioned_user.mention}, got kissed by #{event.user.mention} :kiss:"
            embed.image = Discordrb::Webhooks::EmbedImage.new(url: HTTP.get("https://nekos.life/api/kiss").parse["url"])
          end
        end
      rescue StandardError
        user = user[1..-1]
        mentioned_user = $bot.user(user)
        if mentioned_user.mention == event.user.mention
          event.channel.send_embed do |embed|
            embed.colour = 0xffff00
            embed.description = "#{event.user.mention} Sorry , you can't kiss yourself :cry:. But I can kiss you if you want :blush:"
          end
        else
          event.channel.send_embed do |embed|
            embed.colour = 0xffff00
            embed.description = "#{mentioned_user.mention}, got kissed by #{event.user.mention} :kiss:"
            embed.image = Discordrb::Webhooks::EmbedImage.new(url: HTTP.get("https://nekos.life/api/kiss").parse["url"])
          end
        end
      end
    end
  end
end
