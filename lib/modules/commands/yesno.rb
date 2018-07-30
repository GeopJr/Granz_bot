module Granz::DiscordCommands
  module Yesno
    extend Discordrb::Commands::CommandContainer
    command :yesno, min_args: 1 do |event|
      begin
        arr = ["Yes.", "No."]
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = arr.sample.to_s
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
