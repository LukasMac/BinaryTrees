require_relative 'node'

class BinaryTree
	def initialize
		@root_node = Node.new(nil)
	end

	def search(key)
		@root_node.search(key)
	end
	
	def insert(value)
		@root_node.insert(value)
	end

	def delete(value)
		@root_node.delete(value)
	end

	def to_s
		"#{@root_node.value}->#{@root_node}"
	end
end