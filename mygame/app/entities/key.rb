# Key entity handles key initialization, collision, and rendering
module Key
  class << self
    def init(args)
      args.state.key ||= {
        x: 600,
        y: 100,
        w: 32,
        h: 32,
        dx: 0,
        dy: 0,
        path: 'sprites/square/blue.png',
      }
    end

    def update(args)
      collision = args.state.key.intersect_rect? args.state.player

      if collision
        args.state.player.inventory << "key"
        args.state.key.y = 2000
      end
    end

    def render(args)
      args.outputs.sprites << args.state.key
      # Debug labels
      args.outputs.labels << [100, 100, "key"]
      args.outputs.labels << [500, 500, "#{args.state.player.inventory}"]
    end
  end
end
