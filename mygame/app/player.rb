# Player module handles player initialization, movement, and physics
module Player
  class << self
    def init(args)
      args.state.player ||= {
        x: 120,
        y: GROUND_Y,
        w: 32,
        h: 32,
        vx: 0,
        vy: 0,
        dx: 0,
        dy: 0,
        path: 'sprites/square/red.png',
        inventory: []
      }

      args.state.vx ||= 0
      args.state.vy ||= 0
      args.state.on_ground = (args.state.player.y <= GROUND_Y) if args.state.on_ground.nil?
    end

    def update_movement(args)
      # Horizontal movement
      args.state.vx = 0
      args.state.vx -= SPEED if args.inputs.left
      args.state.vx += SPEED if args.inputs.right
      args.state.player.x += args.state.vx

      # Track movement direction for collision detection
      args.state.player.dx = args.inputs.left_right * 2
      args.state.player.dy = args.inputs.up_down * 2
    end

    def update_physics(args)
      # SINGLE jump: only fires on the press, only if grounded
      if args.inputs.keyboard.key_down.space && args.state.on_ground
        args.state.vy = JUMP_V
        args.state.on_ground = false
      end

      # Gravity
      args.state.vy += GRAVITY
      args.state.vy = [args.state.vy, MAX_FALL_V].max
      args.state.player.y += args.state.vy

      # Ground collision (this is what re-enables jumping)
      if args.state.player.y <= GROUND_Y
        args.state.player.y = GROUND_Y
        args.state.vy = 0
        args.state.on_ground = true
      end
    end
  end
end
