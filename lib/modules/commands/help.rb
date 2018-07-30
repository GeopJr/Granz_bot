module Granz::DiscordCommands
  module Help
    extend Discordrb::Commands::CommandContainer
    command :help do |event|
      begin
        event.channel.send_embed do |embed|
          embed.title = "You called for help , here I am !!!"
          embed.colour = 0xffff00

          embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: "#{Granz::CONFIG["$bot_name"]}##{Granz::CONFIG["$bot_tag"]}", icon_url: "https://cdn.discordapp.com/avatars/443053627419000833/0da891379e4d9d7af31b27ec67c49a3b.png")
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "\xE3\x80\x8EGeop\xE3\x80\x8F#4066", icon_url: "https://cdn.discordapp.com/avatars/216156825978929152/4726ea8789285323ca03e995b9a059bf.png")

          embed.description = "\n__[Command List !](https://granz.geopjr.xyz/commands)__\n\n__Type #{Granz::CONFIG["$prefix"].to_s}info for some info__\n\n__Found a bug? Add me \xE3\x80\x8EGeop\xE3\x80\x8F#4066__\n\n__[Support Server](https://discordbots.org/servers/404294934041067522)__"
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
