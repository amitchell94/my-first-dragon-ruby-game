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
        collected: false
      }
    end

    def update(args)
      return unless args.state.current_scene == 1

      if args.state.player.intersect_rect? args.state.key
        args.state.player.inventory << "key" unless args.state.key.collected
        args.state.key.collected = true
      end
    end

    def render(args)
      return unless args.state.current_scene == 1
      return if args.state.key.collected

      args.outputs.sprites << args.state.key
    end
  end
end
