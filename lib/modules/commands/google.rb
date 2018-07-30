module Granz::DiscordCommands
  module Google
    extend Discordrb::Commands::CommandContainer
    command :google, min_args: 1 do |event, *args|
      begin
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = format("<https://www.google.com/search?q=%s>", args.join("+"))
          embed.description = "Replying to : #{event.user.mention}"
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
