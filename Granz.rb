# Gems
require "discordrb"
require "json"
require "cleverbot"
require "http"
require "vigenere"
# Change these to whatever you want
$prefix = "Your desired prefix"
$version = "Your desired version"
$bot_name = "Your bot's Name"
$bot_tag = "Your bot's tag"
# Change these to their values
$token = "Your Bot's token"
$client_id = "Your Bot's ID"
# Don't change this
$bot = Discordrb::Commands::CommandBot.new token: $token, client_id: $client_id, prefix: $prefix, ignore_bots: true
# Logs a message to your terminal
puts "Connected"
# Used for cleverbot.io , change YOUR_API_USER and YOUR_API_KEY to theur values
talk = Cleverbot.new("YOUR_API_USER", "YOUR_API_KEY")
# Help Command
$bot.command :help do |event|
  begin
    event.channel.send_embed do |embed|
    embed.title = "You called for help , here I am !!!"
    embed.colour = 0xffff00
    embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: "#{$bot_name}#{$bot_tag}", icon_url: "https://cdn.discordapp.com/avatars/443053627419000833/0da891379e4d9d7af31b27ec67c49a3b.png")
    embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "\xE3\x80\x8EGeop\xE3\x80\x8F#4066", icon_url: "https://cdn.discordapp.com/avatars/216156825978929152/4726ea8789285323ca03e995b9a059bf.png")
    embed.description = "\n__[Command List !](https://granz.geopjr.xyz/commands)__\n\n__Type #{$prefix.to_s}info for some info__\n\n__Found a bug? Add me \xE3\x80\x8EGeop\xE3\x80\x8F#4066__\n\n__[Support Server](https://discordbots.org/servers/404294934041067522)__"
  end
  rescue
      event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
# Info
$bot.command :info do |event|
  begin
    event.channel.send_embed do |embed|
    embed.title = "Some Info"
    embed.colour = 0xffff00
    embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: "#{$bot_name}#{$bot_tag}", icon_url: "https://cdn.discordapp.com/avatars/443053627419000833/0da891379e4d9d7af31b27ec67c49a3b.png")
    embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "\xE3\x80\x8EGeop\xE3\x80\x8F#4066", icon_url: "https://cdn.discordapp.com/avatars/216156825978929152/4726ea8789285323ca03e995b9a059bf.png")
    embed.add_field(name: "__Name & Avatar__", value: "Granz is a character made by Mentaiko")
    embed.add_field(name: "__Version__", value: $version.to_s)
    embed.add_field(name: "__Written in__", value: "Ruby using discordrb")
    embed.add_field(name: "__Prefix__", value: $prefix.to_s)
    embed.add_field(name: "__Invite Link__", value: "[HERE](https://discordapp.com/oauth2/authorize?client_id=#{$client_id}&scope=bot&permissions=103894080)")
    embed.add_field(name: "__Support Server__", value: "https://discordbots.org/servers/404294934041067522")
    embed.add_field(name: "__MIT Licenced__", value: "https://github.com/GeopJr/Granz_bot")
    embed.add_field(name: "__Updates__", value: "At least 2 commands a week")
    embed.add_field(name: "__Found an error ?__", value: "<:steam:314349923044687872> [**Steam**](https://steamcommunity.com/id/geopjunior/)\n<:discord:314003252830011395> **『Geop』#4066**\n<:update:264184209617321984> **e-mail**: geopjr@geopjr.xyz")
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end

# Commands
$bot.command :ping do |event|
  begin
    event.channel.send_embed do |embed|
    embed.colour = 0xffff00
    embed.title = ":ping_pong: Pong! (#{Time.now - event.timestamp} sec.)"
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
# Cleverbot
$bot.message do |event|
  begin
  if event.message.content.start_with?("<@#{$bot.profile.id}>") || event.message.content.start_with?("<@#{$bot.profile.id}>")
    event.channel.start_typing
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = talk.say(event.message.content.gsub("<@#{$bot.profile.id}>", "").gsub("<@!#{$bot.profile.id}>", ""))
      embed.description = "Replying to : #{event.user.mention}"
    end
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
#Kick and Ban
$bot.command :kick, min_args: 1, max_args: 1, required_permissions: [:kick_members] do |event, user|
  begin
    event.server.kick(event.bot.parse_mention(user))
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Kicked"
      embed.description = "#{user}"
    end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "I can't do that for some reason"
      embed.description = "Probably I don't have enough permissions or this user has a higher role than me"
    end
  end
end

$bot.command :ban, min_args: 1, max_args: 1, required_permissions: [:ban_members] do |event, user|
  begin
    event.server.ban(event.bot.parse_mention(user))
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Banned"
      embed.description = "#{user}"
    end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "I can't do that for some reason"
      embed.description = "Probably I don't have enough permissions or this user has a higher role than me"
    end
  end
end
#Vigenere Encode and Decode
$bot.command :vencode, min_args: 2 do |event, key, *text|
  message = text.join(" ")
  begin
  event.channel.send_embed do |embed|
    embed.colour = 0xffff00
    embed.title = Vigenere.encode("#{key.upcase}", "#{message.upcase}")
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end

$bot.command :vdecode, min_args: 2 do |event, key, *code|
  message = code.join(" ")
  begin
  event.channel.send_embed do |embed|
    embed.colour = 0xffff00
    embed.title = Vigenere.decode("#{key.upcase}", "#{message.upcase}")
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
# Answers yes or no
$bot.command :yesno, min_args: 1 do |event|
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
# Generates a let me google that for you link
$bot.command :lmgtfy, min_args: 1 do |event, *args|
  begin
    event.channel.send_embed do |embed|
    embed.colour = 0xffff00
    embed.title = format("<http://lmgtfy.com/?q=%s>", args.join("+"))
    embed.description = "Replying to : #{event.user.mention}"
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
# Generates a duckduckgo link
$bot.command :ddg, min_args: 1 do |event, *args|
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
# Generates a google link
$bot.command :google, min_args: 1 do |event, *args|
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
# Responds with the avatar of the tagged user
$bot.command :avatar, min_args: 1, max_args: 1 do |event, user|
  user = user[2..-2]
  begin
    mentioned_user = $bot.user(user)
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.image = Discordrb::Webhooks::EmbedImage.new(url: "#{mentioned_user.avatar_url}?size=1024")
    end
  rescue StandardError
    begin
      user = user[1..-1]
      mentioned_user = $bot.user(user)
      event.channel.send_embed do |embed|
        embed.colour = 0xffff00
        embed.image = Discordrb::Webhooks::EmbedImage.new(url: "#{mentioned_user.avatar_url}?size=1024")
      end
    end
  end
end
# Shows the uptime
$bot.command :uptime do |event|
  full_sec = Time.now - $uptimer
  sec = full_sec % 60
  min = full_sec / 60
  sec = sec.floor
  min = min.floor
  begin
  event.channel.send_embed do |embed|
    embed.title = "Uptime:"
    embed.description = format("%s minutes and %s seconds", min, sec)
    embed.colour = 0xffff00
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
# Kisses tagged user
$bot.command :kiss, min_args: 1, max_args: 1 do |event, user|
  user = user[2..-2]
  begin
    mentioned_user = $bot.user(user)
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.description = "#{mentioned_user.mention}, #{event.user.mention} kissed you :kiss:"
    end
  rescue StandardError
    begin
      user = user[1..-1]
      mentioned_user = $bot.user(user)
      event.channel.send_embed do |embed|
        embed.colour = 0xffff00
        embed.description = "#{mentioned_user.mention}, #{event.user.mention} kissed you :kiss:"
      end
    end
  end
end
# Hugs tagged user
$bot.command :hug, min_args: 1, max_args: 1 do |event, user|
  user = user[2..-2]
  begin
    mentioned_user = $bot.user(user)
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.description = "#{mentioned_user.mention}, #{event.user.mention} hugged you :hugging:"
    end
  rescue StandardError
    begin
      user = user[1..-1]
      mentioned_user = $bot.user(user)
      event.channel.send_embed do |embed|
        embed.colour = 0xffff00
        embed.description = "#{mentioned_user.mention}, #{event.user.mention} hugged you :hugging:"
      end
    end
  end
end
# Notices you
$bot.command :noticeme do |event|
  begin
  event.channel.send_embed do |embed|
    embed.colour = 0xffff00
    embed.description = "#{event.user.mention}, I notice you :relaxed:"
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
# Blushes
$bot.command :blush do |event|
  begin
  event.channel.send_embed do |embed|
    embed.colour = 0xffff00
    embed.image = Discordrb::Webhooks::EmbedImage.new(url: "https://i.imgur.com/fIY6c7d.png")
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
# Shoots tagged user
$bot.command :shoot, min_args: 1, max_args: 1 do |event, user|
  user = user[2..-2]
  begin
    mentioned_user = $bot.user(user)
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.description = "#{mentioned_user.mention}, #{event.user.mention} shot you :gun:"
    end
  rescue StandardError
    begin
      user = user[1..-1]
      mentioned_user = $bot.user(user)
      event.channel.send_embed do |embed|
        embed.colour = 0xffff00
        embed.description = "#{mentioned_user.mention}, #{event.user.mention} shot you :gun:"
      end
    end
  end
end
# Rates something
$bot.command :rate, min_args: 1 do |event, *rating|
  begin
  arr = %w[0 1 2 3 4 5 6 7 8 9 10]
  message = rating.join(" ")
  event.channel.send_embed do |embed|
    embed.colour = 0xffff00
    embed.description = "I give **#{message}** a **#{arr.sample}/10** ~#{$bot_name}"
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
#Chooses between things
$bot.command :choose, min_args: 2 do |event, *choices|
  begin
  arr = choices
  event.channel.send_embed do |embed|
    embed.colour = 0xffff00
    embed.title = "Hmm, I pick :"
    embed.description = "#{arr.sample}"
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
#Tells you how gay something or someone is
$bot.command :howgay, min_args: 1 do |event, *rating|
  begin
  arr = (0..100).to_a
  message = rating.join(" ")
  event.channel.send_embed do |embed|
    embed.title = "How much of a homosexual are you ?"
    embed.colour = 0xffff00
    embed.description = "**#{message}** is **#{arr.sample}/100** homosexual :gay_pride_flag:"
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
#Tells you how cute something or someone is
$bot.command :howcute, min_args: 1 do |event, *rating|
  begin
  arr = (0..100).to_a
  message = rating.join(" ")
  event.channel.send_embed do |embed|
    embed.title = "How cute are you ?"
    embed.colour = 0xffff00
    embed.description = "**#{message}** is **#{arr.sample}/100** cute :blush:"
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
#Rates your waifu
$bot.command :ratewaifu, min_args: 1 do |event, *rating|
  begin
    arr = (0..100).to_a
    message = rating.join(" ")
    event.channel.send_embed do |embed|
      embed.title = "Waifu O' Meter"
      embed.colour = 0xffff00
      embed.description = "My rating for **#{message}** is **#{arr.sample}/100** :princess:"
    end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
#Rates your husbando
$bot.command :ratehusbando, min_args: 1 do |event, *rating|
  begin
    arr = (0..100).to_a
    message = rating.join(" ")
    event.channel.send_embed do |embed|
      embed.title = "Husbando O' Meter"
      embed.colour = 0xffff00
      embed.description = "My rating for **#{message}** is **#{arr.sample}/100** :prince:"
    end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
# Reverses something
$bot.command :reverse, min_args: 1 do |event, *args|
  begin
  event.channel.send_embed do |embed|
    embed.colour = 0xffff00
    embed.title = args.join(" ").reverse.to_s
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
#Lowercase and Uppercase
$bot.command :uppercase, min_args: 1 do |event, *args|
  begin
  event.channel.send_embed do |embed|
    embed.colour = 0xffff00
    embed.title = "#{args.join(" ").upcase}"
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end

$bot.command :lowercase, min_args: 1 do |event, *args|
  begin
  event.channel.send_embed do |embed|
    embed.colour = 0xffff00
    embed.title = "#{args.join(" ").downcase}"
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
# Qrcode Generator
$bot.command :qrcode, min_args: 1 do |event, *args|
  begin
  event.channel.send_embed do |embed|
    embed.image = Discordrb::Webhooks::EmbedImage.new(url: "https://chart.googleapis.com/chart?cht=qr&chs=512x512&chl=#{args.join("+")}")
    embed.color = 0xffff00
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
# Algebra Visualizer
$bot.command :algebra, min_args: 1 do |event, *args|
  begin
  vis = args.join("").gsub("+", "%2B").gsub("=", "%3D").gsub("/", "%2F").gsub(",", "%2C").gsub(".", "%2E")
  event.channel.send_embed do |embed|
    embed.image = Discordrb::Webhooks::EmbedImage.new(url: "https://chart.googleapis.com/chart?cht=tx&chl=#{vis}")
    embed.color = 0xffff00
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
# Converts temperature from F,K,C TO C,F,K
$bot.command :temperature, min_args: 3, max_args: 3 do |event, t, befo, afte|
  bef = befo.downcase
  aft = afte.downcase
  begin
    break unless t.match(/^[0-9_\-+ ]*$/)
    if bef == "celsius" || bef == "c"
      if aft == "celsius" || aft == "c"
        done = "INFINITY"
      elsif aft == "kelvin" || aft == "k"
        done = t.to_i + 273.15
      elsif aft == "fahrenheit" || aft == "f"
        prepare = t.to_i * 1.8
        done = prepare + 32
      end
    elsif bef == "fahrenheit" || bef == "f"
      if aft == "celsius" || aft == "c"
        prepare = t.to_i - 32
        done = prepare / 1.8
      elsif aft == "kelvin" || aft == "k"
        prepare = t.to_i + 459.67
        done = prepare / 1.8
      elsif aft == "fahrenheit" || aft == "f"
        done = "INFINITY"
      end
    elsif bef == "kelvin" || bef == "k"
      if aft == "celsius" || aft == "c"
        done = t.to_i - 273.15
      elsif aft == "kelvin" || aft == "k"
        done = "INFINITY"
      elsif aft == "fahrenheit" || aft == "f"
        prepare = t.to_i * 1.8
        done = prepare - 459.67
      end
    end
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "#{done}"
    end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Only Numbers Please"
    end
  end
end
# Responds with the id of the tagged user
$bot.command :id, min_args: 1, max_args: 1 do |event, user|
  user = user[2..-2]
  begin
    mentioned_user = $bot.user(user)
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = mentioned_user.mention.to_s
    end
  rescue StandardError
    begin
      user = user[1..-1]
      mentioned_user = $bot.user(user)
      event.channel.send_embed do |embed|
        embed.colour = 0xffff00
        embed.title = mentioned_user.mention.to_s
      end
    end
  end
end
# Responds with a random shiba inu
$bot.command :doge do |event|
  begin
  event.channel.send_embed do |embed|
    embed.image = Discordrb::Webhooks::EmbedImage.new(url: HTTP.get("http://shibe.online/api/shibes?count=1").parse[0])
    embed.color = 0xffff00
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
#Responds with a random fox
$bot.command :fox do |event|
  begin
  event.channel.send_embed do |embed|
    embed.image = Discordrb::Webhooks::EmbedImage.new(url: HTTP.get("https://randomfox.ca/floof/").parse["image"])
    embed.color = 0xffff00
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
#Responds with a random dog
$bot.command :dog do |event|
  begin
  event.channel.send_embed do |embed|
    embed.image = Discordrb::Webhooks::EmbedImage.new(url: HTTP.get("https://random.dog/woof.json").parse["url"])
    embed.color = 0xffff00
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
# Responds with a random cat
$bot.command :cat do |event|
  begin
  event.channel.send_embed do |embed|
    embed.image = Discordrb::Webhooks::EmbedImage.new(url: HTTP.get("http://shibe.online/api/cats?count=1").parse[0])
    embed.color = 0xffff00
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
# Responds with a random bird
$bot.command :bird do |event|
  begin
  event.channel.send_embed do |embed|
    embed.image = Discordrb::Webhooks::EmbedImage.new(url: HTTP.get("http://shibe.online/api/birds?count=1").parse[0])
    embed.color = 0xffff00
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
# #Responds with a bara image
# $bot.command :bara do |event|
# next event.respond "I'm sorry. I can't do that because this is a SFW channel." unless event.channel.nsfw
#   event.channel.send_embed do |embed|
#   embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "https://barapi.geopjr.xyz/")
#   embed.image = Discordrb::Webhooks::EmbedImage.new(url: HTTP.get('https://barapi.000webhostapp.com/api/random.php').parse[0])
#   embed.color = 0xffff00
#   end
# end
#Responds with a random coffee image
$bot.command :coffee do |event|
  begin
  event.channel.send_embed do |embed|
    embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "https://coffee.alexflipnote.xyz/")
    embed.image = Discordrb::Webhooks::EmbedImage.new(url: HTTP.get("https://coffee.alexflipnote.xyz/random.json").parse["file"])
    embed.color = 0xffff00
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
#Responds with a random trump quote
$bot.command :trump do |event|
  begin
  event.channel.send_embed do |embed|
    embed.title = HTTP.get("https://api.whatdoestrumpthink.com/api/v1/quotes/random").parse["message"]
    embed.colour = 0xffff00
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
# Responses with a cookie and a fortune
$bot.command :cookie do |event|
  begin
  event.channel.send_embed do |embed|
    embed.colour = 0xffff00
    embed.title = ":cookie:"
    embed.description = HTTP.get("http://www.yerkee.com/api/fortune").parse["fortune"]
  end
  event.message.react "🍪"
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
#Amiibo search
$bot.command :amiibo, min_args: 1, max_args: 1 do |event, name|
  begin
    url = URI.escape("http://www.amiiboapi.com/api/amiibo/?name=#{name}")
    parse = JSON.parse(RestClient.get(url))
    img = parse["amiibo"][0]["image"]
    eu = parse["amiibo"][0]["release"]["eu"]
    au = parse["amiibo"][0]["release"]["au"]
    jp = parse["amiibo"][0]["release"]["jp"]
    na = parse["amiibo"][0]["release"]["na"]
    event.channel.send_embed do |embed|
      embed.title = parse["amiibo"][0]["character"]
      embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: "#{img}")
      embed.color = 0xffff00
      embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: "#{$bot_name}#{$bot_tag}", icon_url: "https://cdn.discordapp.com/avatars/443053627419000833/0da891379e4d9d7af31b27ec67c49a3b.png")
      embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "\xE3\x80\x8EGeop\xE3\x80\x8F#4066", icon_url: "https://cdn.discordapp.com/avatars/216156825978929152/4726ea8789285323ca03e995b9a059bf.png")
      embed.add_field(name: "__Amiibo Series__", value: parse["amiibo"][0]["amiiboSeries"])
      embed.add_field(name: "__Game Series__", value: parse["amiibo"][0]["gameSeries"])
      embed.add_field(name: "__Release Day__", value: "**AU:** #{au}\n**EU:** #{eu}\n**JP:** #{jp}\n**NA:** #{na}")
    end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Not Found"
    end
  end
end
#Generates Acronyms
$bot.command :acronym, min_args: 1, max_args: 1 do |event, acro|
  begin
    break unless acro.match(/^[a-zA-Z_\-+ ]*$/)
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "#{acro} Stands For :"
      embed.description = HTTP.get("https://api.chew.pro/acronym/#{acro}").parse["phrase"]
      embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "https://chew.pro/")
    end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Only Latin Letters Please"
    end
  end
end
#Responds with a joke
$bot.command :joke do |event|
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
#Responds with a norris joke
$bot.command :norris do |event|
  begin
  url = URI.escape("http://api.icndb.com/jokes/random")
  parse = JSON.parse(RestClient.get(url))
  event.channel.send_embed do |embed|
    embed.colour = 0xffff00
    embed.title = parse["value"]["joke"]
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
#Tanki Stats
$bot.command :tanki, min_args: 1, max_args: 1 do |event, nick|
  begin
    url = URI.escape("http://ratings.tankionline.com/get_stat/profile/?user=#{nick}&lang=en")
    parse = JSON.parse(RestClient.get(url))
    if parse["response"]["rank"] == 1
      rank = "Recruit"
      rimg = "https://i.imgur.com/ZcBNexc.png"
    elsif parse["response"]["rank"] == 2
      rank = "Private"
      rimg = "https://i.imgur.com/Jaar0MF.png"
    elsif parse["response"]["rank"] == 3
      rank = "Gefreiter"
      rimg = "https://i.imgur.com/j2DfBdW.png"
    elsif parse["response"]["rank"] == 4
      rank = "Corporal"
      rimg = "https://i.imgur.com/7Pn4X88.png"
    elsif parse["response"]["rank"] == 5
      rank = "Master Corporal"
      rimg = "https://i.imgur.com/WKZ0sVp.png"
    elsif parse["response"]["rank"] == 6
      rank = "Sergeant"
      rimg = "https://i.imgur.com/O2WuJAJ.png"
    elsif parse["response"]["rank"] == 7
      rank = "Staff Sergeant"
      rimg = "https://i.imgur.com/bTQLm9h.png"
    elsif parse["response"]["rank"] == 8
      rank = "Master Sergeant"
      rimg = "https://i.imgur.com/VvivZg0.png"
    elsif parse["response"]["rank"] == 9
      rank = "First Sergeant"
      rimg = "https://i.imgur.com/rCkln3K.png"
    elsif parse["response"]["rank"] == 10
      rank = "Sergeant-Major"
      rimg = "https://i.imgur.com/xCKvB2G.png"
    elsif parse["response"]["rank"] == 11
      rank = "Warrant Officer 1"
      rimg = "https://i.imgur.com/TJKJ4eB.png"
    elsif parse["response"]["rank"] == 12
      rank = "Warrant Officer 2"
      rimg = "https://i.imgur.com/Q8U5QIz.png"
    elsif parse["response"]["rank"] == 13
      rank = "Warrant Officer 3"
      rimg = "https://i.imgur.com/Ygi65T7.png"
    elsif parse["response"]["rank"] == 14
      rank = "Warrant Officer 4"
      rimg = "https://i.imgur.com/rx0zDOR.png"
    elsif parse["response"]["rank"] == 15
      rank = "Warrant Officer 5"
      rimg = "https://i.imgur.com/jDmMo5j.png"
    elsif parse["response"]["rank"] == 16
      rank = "Third Lieutenant"
      rimg = "https://i.imgur.com/LLvlTZY.png"
    elsif parse["response"]["rank"] == 17
      rank = "Second Lieutenant"
      rimg = "https://i.imgur.com/1Oor2V6.png"
    elsif parse["response"]["rank"] == 18
      rank = "First Lieutenant"
      rimg = "https://i.imgur.com/03s6YiZ.png"
    elsif parse["response"]["rank"] == 19
      rank = "Captain"
      rimg = "https://i.imgur.com/kf8Uo7U.png"
    elsif parse["response"]["rank"] == 20
      rank = "Major"
      rimg = "https://i.imgur.com/Zl9q3rP.png"
    elsif parse["response"]["rank"] == 21
      rank = "Lieutenant Colonel"
      rimg = "https://i.imgur.com/bmTEps1.png"
    elsif parse["response"]["rank"] == 22
      rank = "Colonel"
      rimg = "https://i.imgur.com/Ac9S6w7.png"
    elsif parse["response"]["rank"] == 23
      rank = "Brigadier"
      rimg = "https://i.imgur.com/vBo95NA.png"
    elsif parse["response"]["rank"] == 24
      rank = "Major General"
      rimg = "https://i.imgur.com/YOuPegl.png"
    elsif parse["response"]["rank"] == 25
      rank = "Lieutenant General"
      rimg = "https://i.imgur.com/dYh43EF.png"
    elsif parse["response"]["rank"] == 26
      rank = "General"
      rimg = "https://i.imgur.com/59NrDOX.png"
    elsif parse["response"]["rank"] == 27
      rank = "Marshal"
      rimg = "https://i.imgur.com/S4smUqx.png"
    elsif parse["response"]["rank"] == 28
      rank = "Field Marshal"
      rimg = "https://i.imgur.com/DRmWUfj.png"
    elsif parse["response"]["rank"] == 29
      rank = "Commander"
      rimg = "https://i.imgur.com/lZu9Rqt.png"
    elsif parse["response"]["rank"] == 30
      rank = "Generalissimo"
      rimg = "https://i.imgur.com/Fggz9xh.png"
    elsif parse["response"]["rank"] > 31
      numrank = parse["response"]["rank"] - 30
      rank = "Legend #{numrank}"
      rimg = "https://i.imgur.com/NahcZQ9.png"
    else parse["response"]["rank"] == 31
      rank = "Legend"
      rimg = "https://i.imgur.com/NahcZQ9.png"     end

    exp = parse["response"]["score"]
    expc = parse["response"]["scoreNext"]
    nex = parse["response"]["scoreNext"] - parse["response"]["score"]
    if parse["response"]["hasPremium"] == false
      prem = "No"
    else parse["response"]["hasPremium"] == true
      prem = "yes"     end
    crys = parse["response"]["earnedCrystals"]
    gold = parse["response"]["caughtGolds"]
    kills = parse["response"]["kills"]
    deaths = parse["response"]["deaths"]
    kd = kills.to_f / deaths
    if parse["response"]["rating"]["efficiency"]["position"] == -1
      eplac = "-"
    else
      eplac = parse["response"]["rating"]["efficiency"]["position"].to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
    end
    if parse["response"]["rating"]["efficiency"]["value"] == -1
      evalu = "-"
    else
      evalu = parse["response"]["rating"]["efficiency"]["value"].round(-2).to_s.chomp("00").chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
    end
    if parse["response"]["rating"]["score"]["position"] == -1
      explac = "-"
    else
      explac = parse["response"]["rating"]["score"]["position"].to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
    end
    if parse["response"]["rating"]["score"]["value"] == -1
      exvalu = "-"
    else
      exvalu = parse["response"]["rating"]["score"]["value"].to_s.chomp("00").chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
    end
    if parse["response"]["rating"]["golds"]["position"] == -1
      gplac = "-"
    else
      gplac = parse["response"]["rating"]["golds"]["position"].to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
    end
    if parse["response"]["rating"]["golds"]["value"] == -1
      gvalu = "-"
    else
      gvalu = parse["response"]["rating"]["golds"]["value"].to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
    end
    if parse["response"]["rating"]["crystals"]["position"] == -1
      cryplac = "-"
    else
      cryplac = parse["response"]["rating"]["crystals"]["position"].to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
    end
    if parse["response"]["rating"]["crystals"]["value"] == -1
      cryvalu = "-"
    else
      cryvalu = parse["response"]["rating"]["crystals"]["value"].to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
    end
    event.channel.send_embed do |embed|
      embed.title = "Stats of #{nick}"
      embed.url = "http://ratings.tankionline.com/en/user/#{nick}/"
      embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: "#{rimg}")
      embed.color = 0xffff00
      embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: "#{$bot_name}#{$bot_tag}", icon_url: "https://cdn.discordapp.com/avatars/443053627419000833/0da891379e4d9d7af31b27ec67c49a3b.png")
      embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "\xE3\x80\x8EGeop\xE3\x80\x8F#4066", icon_url: "https://cdn.discordapp.com/avatars/216156825978929152/4726ea8789285323ca03e995b9a059bf.png")

      embed.add_field(name: "__Name__", value: parse["response"]["name"])
      embed.add_field(name: "__Rank__", value: "#{rank}")
      embed.add_field(name: "__Premium__", value: "#{prem}")
      embed.add_field(name: "__EXP__", value: "#{exp.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse}/#{expc.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse}")
      embed.add_field(name: "__EXP left to rank up__", value: "#{nex.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse} exp")
      embed.add_field(name: "__Caught Golden Boxes__", value: "#{gold.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse}")
      embed.add_field(name: "__Obtained Crystals__", value: "#{crys.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse}")
      embed.add_field(name: "__Kills__", value: "#{kills.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse}", inline: true)
      embed.add_field(name: "__Deaths__", value: "#{deaths.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse}", inline: true)
      embed.add_field(name: "__K/D Ratio__", value: "#{kd.round(2)}", inline: true)
      embed.add_field(name: "__Efficiency Rating Place | Value__", value: "#{eplac} | #{evalu}")
      embed.add_field(name: "__Experience Rating Place | Value__", value: "#{explac} | #{exvalu}")
      embed.add_field(name: "__Gold Box Rating Place | Value__", value: "#{gplac} | #{gvalu}")
      embed.add_field(name: "__Crystals Rating Place | Value__", value: "#{cryplac} | #{cryvalu}")
    end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "I am afraid there is not such user in existance"
    end
  end
end
#Minecraft uuid finder
$bot.command :mcuuid, max_args: 1 do |event, username|
  begin
    url = URI.escape("https://api.mojang.com/users/profiles/minecraft/#{username}")
    parse = JSON.parse(RestClient.get(url))
    name = parse["name"]
    uuid = parse["id"]
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: "https://crafatar.com/renders/head/#{uuid}?overlay")
      embed.title = "#{name}'s UUID is :"
      embed.description = "#{uuid}"
    end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end
#Minecraft skin search
$bot.command :mcskin, max_args: 1 do |event, uuid|
  event.channel.send_embed do |embed|
    embed.colour = 0xffff00
    embed.image = Discordrb::Webhooks::EmbedImage.new(url: "https://crafatar.com/skins/#{uuid}")
    embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: "https://crafatar.com/renders/head/#{uuid}?overlay")
    embed.title = "Here you go :"
    embed.description = "https://crafatar.com/skins/#{uuid}"
  end
end
#Minecraft Status
$bot.command :mcstatus do |event|
  url = URI.escape("https://status.mojang.com/check")
  parse = JSON.parse(RestClient.get(url))
  if parse[0]["minecraft.net"] == "green"
    minecraft = "<:check:314349398811475968>"
  elsif parse[0]["minecraft.net"] == "yellow"
    minecraft = ":warning:"
  else
    minecraft = "<:xmark:314349398824058880>"
  end
  if parse[1]["session.minecraft.net"] == "green"
    session = "<:check:314349398811475968>"
  elsif parse[1]["session.minecraft.net"] == "yellow"
    session = ":warning:"
  else
    session = "<:xmark:314349398824058880>"
  end
  if parse[2]["account.mojang.com"] == "green"
    acc = "<:check:314349398811475968>"
  elsif parse[2]["account.mojang.com"] == "yellow"
    acc = ":warning:"
  else
    acc = "<:xmark:314349398824058880>"
  end
  if parse[3]["authserver.mojang.com"] == "green"
    aserv = "<:check:314349398811475968>"
  elsif parse[3]["authserver.mojang.com"] == "yellow"
    aserv = ":warning:"
  else
    aserv = "<:xmark:314349398824058880>"
  end
  if parse[4]["sessionserver.mojang.com"] == "green"
    sserv = "<:check:314349398811475968>"
  elsif parse[4]["sessionserver.mojang.com"] == "yellow"
    sserv = ":warning:"
  else
    sserv = "<:xmark:314349398824058880>"
  end
  if parse[5]["api.mojang.com"] == "green"
    api = "<:check:314349398811475968>"
  elsif parse[5]["api.mojang.com"] == "yellow"
    api = ":warning:"
  else
    api = "<:xmark:314349398824058880>"
  end
  if parse[6]["textures.minecraft.net"] == "green"
    textures = "<:check:314349398811475968>"
  elsif parse[6]["textures.minecraft.net"] == "yellow"
    textures = ":warning:"
  else
    textures = "<:xmark:314349398824058880>"
  end
  if parse[7]["mojang.com"] == "green"
    moj = "<:check:314349398811475968>"
  elsif parse[7]["mojang.com"] == "yellow"
    moj = ":warning:"
  else
    moj = "<:xmark:314349398824058880>"
  end
  event.channel.send_embed do |embed|
    embed.colour = 0xffff00
    embed.title = "Minecraft Status"
    embed.add_field(name: "__Minecraft.net__", value: "#{minecraft}")
    embed.add_field(name: "__Sessions__", value: "#{session}")
    embed.add_field(name: "__Accounts__", value: "#{acc}")
    embed.add_field(name: "__Auth Server__", value: "#{aserv}")
    embed.add_field(name: "__Session Server__", value: "#{sserv}")
    embed.add_field(name: "__API__", value: "#{api}")
    embed.add_field(name: "__Textures__", value: "#{textures}")
    embed.add_field(name: "__Mojang.com__", value: "#{moj}")
  end
end
#Stats about the bot
$bot.command :stats do |event|
  begin
  members = 0
  event.bot.servers.each { |x, y| members = members + y.member_count }
  event.channel.send_embed do |embed|
    embed.colour = 0xffff00
    embed.title = "Stats"
    embed.description = "Currently I'm on **#{event.bot.servers.size} servers** with a total user count of **#{members} users** in **#{event.bot.servers.collect { |x, y| y.channels.size }.inject(0, &:+)} channels**!"
  end
  rescue
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Error"
    end
  end
end

=begin
$bot.command :eval do |event, *code|
  break unless event.user.id == 216_156_825_978_929_152
  begin
    input = eval code.join(" ")
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Success :white_check_mark:"
      embed.description = ":inbox_tray: Input:\n```#{code.join(" ")}```\n:outbox_tray: Output:\n```⠀#{input}```"
    end
  rescue StandardError => e
    event.channel.send_embed do |embed|
      embed.colour = 0xffff00
      embed.title = "Forgive me for I have sinned :pensive:"
      embed.description = ":inbox_tray: Input:\n```#{code.join(" ")}```\n:outbox_tray: Output:\n```#{e}```"
    end
  end
end
=end
=begin
$bot.command :restart do |event|
  break unless event.user.id == YOUR_ID
  $bot.stop
  exit
end
=end

# Playing Game
$bot.ready do |_event|
  $uptimer = Time.now
  $bot.listening = "#{$prefix}help | in #{_event.bot.servers.count} servers"
end
# No need to explain
$bot.run
