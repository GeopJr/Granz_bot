module Granz::DiscordCommands
  module Achievement
    extend Discordrb::Commands::CommandContainer
    command :achievement, min_args: 2 do |event, item, *argss|
      begin
        break unless item.match(/^[0-9_\-+ ]*$/)
        args = argss.join(" ").split("|")
        title = args[0].gsub("+", "%2B").gsub(" ", "+")
        desc = args[1].gsub("+", "%2B").gsub(" ", "+")
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = "Achievement Unlocked"
          embed.image = Discordrb::Webhooks::EmbedImage.new(url: "https://www.minecraftskinstealer.com/achievement/a.php?i=#{item}&h=#{title}&t=#{desc}")
        end
      rescue
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = "Error"
          embed.description = "**#{$prefix}achievement <id> <title>|<description>**\n\nThe id's are located [__here__](https://granz.geopjr.xyz/ids.html)"
        end
      end
    end
  end
end
