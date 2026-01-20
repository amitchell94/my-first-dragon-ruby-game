module UI
  class << self
    def init(args)
      args.state.inventory ||= []
    end

    def update(args)
      args.state.inventory = args.state.player.inventory
    end

    def render_inventory(args)
      args.outputs.labels << { x: 50, y: 700, text: "Inventory: #{args.state.player.inventory.join(", ")}" }
    end

    def render(args)
      render_inventory(args)
    end
  end
end