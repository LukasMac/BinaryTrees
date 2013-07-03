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
end