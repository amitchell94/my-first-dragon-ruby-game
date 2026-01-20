# Door entity handles door initialization, collision, and unlocking
module Door
  class << self
    def init(args)
      args.state.door ||= {
        x: 900,
        y: 100,
        w: 30,
        h: 200,
        dx: 0,
        dy: 0,
        path: 'sprites/square/blue.png',
        unlocked: false
      }
    end

    def update(args)
      return unless args.state.current_scene == 2
      return if args.state.door.unlocked

      if args.state.player.intersect_rect? args.state.door
        if args.state.player.inventory.include?("key")
          args.state.player.inventory.delete("key")
          args.state.door.unlocked = true
        elsif args.state.player.dx > 0
          args.state.player.x = args.state.door.x - args.state.player.w
        elsif args.state.player.dx < 0
          args.state.player.x = args.state.door.x + args.state.door.w
        end
        args.state.player.dx = 0
      end
    end

    def render(args)
      return unless args.state.current_scene == 2
      return if args.state.door.unlocked

      args.outputs.sprites << args.state.door
    end
  end
end
