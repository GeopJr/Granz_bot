module Granz::DiscordCommands
  module Eval
    extend Discordrb::Commands::CommandContainer
    command :eval do |event, *code|
      break unless event.user.id == Granz::CONFIG["$my_id"]
      begin
        input = eval code.join(" ")
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = "Success"
          embed.description = ":inbox_tray: Input:\n```#{code.join(" ")} ```\n:outbox_tray: Output:\n```⠀#{input}```"
        end
      rescue StandardError => e
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = "Forgive me for I have sinned :pensive:"
          embed.description = ":inbox_tray: Input:\n```#{code.join(" ")} ```\n:outbox_tray: Output:\n```#{e}```"
        end
      end
    end
  end
end
