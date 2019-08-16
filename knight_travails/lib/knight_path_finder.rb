require_relative "00_tree_node"

class KnightPathFinder

  attr_reader :root_node, :start_pos
  attr_accessor :considered_positions

  def initialize(pos)
    @root_node = PolyTreeNode.new(pos)
    @considered_positions = []
    @start_pos = pos 
  end

  def self.valid_moves(pos)
    row, col = pos
    arr = []
    (row - 2..row + 2).each do |step|
      (col - 2..col + 2).each do |column|
        if (0...8).include?(step) && step != row && (0...8).include?(column) && column != col
          slope = (column - col) / (step - row).to_f
          if (slope.abs == 2 || slope.abs == 0.5 )
            arr << [step, column]
          end
        end
      end
    end
    arr
  end

  def new_move_positions(pos)
    new_arr = []
    valid_positions = KnightPathFinder.valid_moves(pos)
    valid_positions.each do |position|
      if !self.considered_positions.include?(position)
        self.considered_positions << position
        new_arr << position
      end
    end
    new_arr
  end

  def build_move_tree
    queue = [self.root_node]
    until queue.empty?
      current_node = queue.shift
      array = self.new_move_positions(current_node.value)
      array.each do |pos|
        node = PolyTreeNode.new(pos)
        current_node.add_child(node)
        queue << node
      end
    end
  end

  def find_path(end_pos)
    self.build_move_tree
    found_node = self.root_node.bfs(end_pos)
    trace_path_back(found_node)
  end

  def trace_path_back(node)
    path = [node]
    until path[0] == self.root_node
      current_node = path[0]
      parent = current_node.parent
      path.unshift(parent)
    end
    path.map {|node| node.value}

  end
  
end

# kpf = KnightPathFinder.new([0, 0])
# p kpf.find_path([7, 6])
# p kpf.find_path([6, 2])

