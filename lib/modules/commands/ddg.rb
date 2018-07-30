module Granz::DiscordCommands
  module Ddg
    extend Discordrb::Commands::CommandContainer
    command :ddg, min_args: 1 do |event, *args|
      begin
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = format("<http://duckduckgo.com/%s?ia=web>", args.join("%20"))
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
