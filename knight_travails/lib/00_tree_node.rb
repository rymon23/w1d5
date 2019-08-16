# require "byebug"
class PolyTreeNode
  attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    if !self.parent.nil? && node != self.parent
      self.parent.children.reject! {|child| child == self}
    end
    @parent = node
    if !node.nil? && !node.children.include?(self)
      node.children << self
    end
  end

  def add_child(node)
    if !node.nil?
      node.parent = self
    end
  end

  def remove_child(node)
    if !self.children.include?(node)
      raise "node is not a child"
    end
    node.parent = nil
  end

  def dfs(target)
    return self if self.value == target

    self.children.each do |child|
      val = child.dfs(target)
      return val if !val.nil?
    end
    nil

  end

  def bfs(target)
    queue = []
    queue << self
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target 
      current_node.children.each do |child|
        queue << child
      end
    end
    nil
  end

end