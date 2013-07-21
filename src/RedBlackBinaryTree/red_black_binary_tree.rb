require_relative 'red_black_binary_tree_node'

class RedBlackBinaryTree
	def initialize
		@root_node = RedBlackBinaryTreeNode.new(nil)
	end

	def insert(value)
		@root_node.insert(value)
	end

	def root
		@root_node
	end

	def left_depth
		@root_node.left.depth
	end

	def right_depth
		@root_node.left.depth
	end

	def max_depth
		[right_depth, left_depth].max
	end
end