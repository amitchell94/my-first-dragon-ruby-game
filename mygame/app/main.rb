# Require all game modules
require 'app/constants.rb'
require 'app/player.rb'
require 'app/scene_manager.rb'
require 'app/entities/key.rb'
require 'app/entities/door.rb'

def tick args
  # Initialize all systems
  Player.init(args)
  SceneManager.init(args)
  Key.init(args)
  Door.init(args)

  # Update game systems
  Player.update_movement(args)
  Player.update_physics(args)
  SceneManager.check_transitions(args)
  Key.update(args)
  Door.update(args)

  # Render everything
  SceneManager.render(args)
  Key.render(args)
  Door.render(args)
  args.outputs.sprites << args.state.player
end
