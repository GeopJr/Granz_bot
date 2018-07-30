module Granz::DiscordCommands
  module Joke
    extend Discordrb::Commands::CommandContainer
    command :joke do |event|
      begin
        url = URI.escape("https://08ad1pao69.execute-api.us-east-1.amazonaws.com/dev/random_joke")
        parse = JSON.parse(RestClient.get(url))
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = parse["setup"]
          embed.description = parse["punchline"]
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
