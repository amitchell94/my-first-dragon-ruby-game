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
      }
    end

    def update(args)
      return unless args.state.current_scene == 2

      door_collision = args.state.door.intersect_rect? args.state.player

      if door_collision
        if args.state.player.inventory.include?("key")
          args.state.door.y = 2000
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

      args.outputs.sprites << args.state.door
      # Debug label
      door_collision = args.state.door.intersect_rect? args.state.player
      args.outputs.labels << [333, 333, "#{door_collision}"]
    end
  end
end
