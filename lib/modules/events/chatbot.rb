module Granz::DiscordEvents
  module Chatbot
    extend Discordrb::EventContainer
    message do |event|
      talk = Cleverbot.new(Granz::CONFIG["$talk_user"], Granz::CONFIG["$talk_key"])
      if event.message.content.start_with?("<@#{$bot.profile.id}>") || event.message.content.start_with?("<@#{$bot.profile.id}>")
        event.channel.start_typing
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = talk.say(event.message.content.gsub("<@#{$bot.profile.id}>", "").gsub("<@!#{$bot.profile.id}>", ""))
          embed.description = "Replying to : #{event.user.mention}"
        end
      end
    end
  end
end
