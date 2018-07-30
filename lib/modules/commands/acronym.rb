module Granz::DiscordCommands
  module Acronym
    extend Discordrb::Commands::CommandContainer
    command :acronym, min_args: 1, max_args: 1 do |event, acro|
      begin
        break unless acro.match(/^[a-zA-Z_\-+ ]*$/)
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = "#{acro} Stands For :"
          embed.description = HTTP.get("https://api.chew.pro/acronym/#{acro}").parse["phrase"]
        end
      rescue
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = "Only Latin Letters Please"
        end
      end
    end
  end
end
