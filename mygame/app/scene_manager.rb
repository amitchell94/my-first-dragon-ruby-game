# SceneManager module handles scene transitions and rendering
module SceneManager
  class << self
    def init(args)
      args.state.current_scene ||= 1
    end

    def render(args)
      case args.state.current_scene
      when 1
        draw_floor(args, 100, 0, 0)
      when 2
        draw_floor(args, 0, 100, 0)
      end
    end

    def check_transitions(args)
      go_right(args) if args.state.player.x > (args.grid.w - PLAYER_W)
      go_left(args)  if args.state.player.x < 0
    end

    def go_right(args)
      if args.state.current_scene < 2
        args.state.current_scene += 1
        args.state.player.x = 10
      else
        args.state.player.x = args.grid.w - 100
      end
    end

    def go_left(args)
      if args.state.current_scene > 1
        args.state.current_scene -= 1
        args.state.player.x = args.grid.w - 200
      else
        args.state.player.x = 0
      end
    end

    private

    def draw_floor(args, r, g, b)
      args.outputs.lines << {
        x: 0, y: 100, x2: args.grid.w, y2: 100,
        r: r, g: g, b: b, a: 255
      }
    end
  end
end
