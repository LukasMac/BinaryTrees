class Node
	attr_reader :value, :right_leaf, :left_leaf

	def initialize(value)
		@value = value 

		unless @value.nil?
			@left_leaf = Node.new(nil)
			@right_leaf = Node.new(nil)
		end
	end


	def search(value)
		return false if @value.nil?

		if value > @value
			@right_leaf.search(value)
		elsif value < @value			
			@left_leaf.search(value)
		else
			true
		end
	end


	def insert(value)
		return initialize_node(value) if @value.nil?

		if value > @value
		  @right_leaf.insert(value)
		else
			@left_leaf.insert(value)
		end
	end

	def insert_node(node)
		return if node.value.nil?

		if @value.nil?
			@value = node.value
			@right_leaf = node.right_leaf
			@left_leaf = node.left_leaf
		elsif @value > node.value
			@right_leaf.insert_node(node)
		elsif @value < node.value
			@left_leaf.insert_node(node)
		end
	end


	def delete(value)
		return false if @value.nil?

		if value > @value
			@right_leaf.delete(value)
		elsif value < @value			
			@left_leaf.delete(value)
		else
			@right_leaf.insert_node(@left_leaf)

			@value = @right_leaf.value
			@left_leaf = @right_leaf.left_leaf
			@right_leaf = @right_leaf.right_leaf

			true
		end
	end

	def to_s
		if @left_leaf.nil? && @right_leaf.nil?
			""
		elsif @left_leaf.value.nil? && @right_leaf.value.nil?
			" #{@left_leaf.value} , #{@right_leaf.value} "		
		else
			" #{@left_leaf.value} , #{@right_leaf.value} ->#{@left_leaf};#{@right_leaf}"
		end
	end

	private

	def initialize_node(value)
		@left_leaf = Node.new(nil)
		@right_leaf = Node.new(nil)
		@value = value

		true
	end
	
end