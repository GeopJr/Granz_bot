module Granz::DiscordCommands
  module Temperature
    extend Discordrb::Commands::CommandContainer
    command :temperature, min_args: 3, max_args: 3 do |event, t, befo, afte|
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
  end
end
