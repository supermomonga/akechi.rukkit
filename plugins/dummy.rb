import 'org.bukkit.Sound'

module Dummy
  extend self
  extend Rukkit::Util

  # def on_player_toggle_sneak(evt)
  #   player = evt.player
  #   if player.name == 'ujm'
  #     play_sound(add_loc(player.location, 0, 5, 0), Sound.values.to_a.sample, 1.0, 0.0)
  #   end
  # end

  def on_command(sender, command, label, args)
    return unless label == 'rukkit'

    args = args.to_a
    case args.shift
    when 'eval'
      # very dangerous!
      later(0) do
        begin
          # how to handle double-space?
          sender.send_message(eval(args.join(' ')).inspect)
        rescue => e
          sender.send_message(e.inspect)
        end
      end
    when 'what-time'
      broadcast Time.now.to_s
    when 'virtual'
      material = Material.const_get(args.shift.upcase) rescue return
      Bukkit.online_players.each do |player|
        player.send_block_change(sender.location, material, 0)
      end
    else
    end
  end

  def on_player_move(evt)
    # player = evt.player
    # Bukkit.online_players.each do |player|
    #   player.send_block_change(player.location, Material::CARPET, 0)
    # end
  end
end
