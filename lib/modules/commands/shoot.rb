module Granz::DiscordCommands
  module Shoot
    extend Discordrb::Commands::CommandContainer
    command :shoot, min_args: 1, max_args: 1 do |event, user|
      user = user[2..-2]
      begin
        mentioned_user = $bot.user(user)
        if mentioned_user.mention == event.user.mention
          event.channel.send_embed do |embed|
            embed.colour = 0xffff00
            embed.description = "#{event.user.mention} If you are feeling suicidal, talk to someone or call your country's suicide prevention hotline"
          end
        else
          event.channel.send_embed do |embed|
            embed.colour = 0xffff00
            embed.description = "#{mentioned_user.mention}, got shot by #{event.user.mention} :gun:"
          end
        end
      rescue StandardError
        user = user[1..-1]
        mentioned_user = $bot.user(user)
        if mentioned_user.mention == event.user.mention
          event.channel.send_embed do |embed|
            embed.colour = 0xffff00
            embed.description = "#{event.user.mention} If you are feeling suicidal, talk to someone or call your country's suicide prevention hotline"
          end
        else
          event.channel.send_embed do |embed|
            embed.colour = 0xffff00
            embed.description = "#{mentioned_user.mention}, got shot by #{event.user.mention} :gun:"
          end
        end
      end
    end
  end
end
