class RedBlackBinaryTreeNode
	attr_reader :value, :is_red, :left, :right, :parent
	attr_writer :value, :left, :right, :parent

	def initialize(parent_node)
		@parent, @value, @is_red = parent_node, nil, false
	end

	def insert(value)
		return initialize_node(value) if @value.nil?

		if value > @value
			@right.insert(value)
		elsif value < @value
			@left.insert(value)
		end
	end

	def get_uncle
		return nil if @parent.nil? || @parent.parent.nil?

		uncle = nil
		grand_parent =  @parent.parent
		is_parent_left_leaf = grand_parent.left == @parent

		if is_parent_left_leaf
			uncle = @parent.parent.right
		else
			uncle = @parent.parent.left
		end

		uncle
	end

	def uncle_is_red?
		return nil if get_uncle.nil?

		get_uncle.is_red?
	end

	def color_black
		@is_red = false
	end

	def color_red
		# Don't color root node, it is always black
		return if @parent.nil?
		
		@is_red = true
	end

	def is_black?
		!@is_red 
	end

	alias_method :is_red?, :is_red

	def nil?
		@value == nil
	end

	private
	# 
	# PRIVATE METHODS
	# 
	

	def correct_tree
		case1_correct
		# case2_correct
		case3_correct
	end

	# -- Case 1: node’s uncle is red --
	# Color Node’s father and uncle black
	# Color Node’s grandfather red
	def case1_correct
		return if @parent.nil? || @parent.parent.nil?

		# Color Node’s father and uncle black
		@parent.color_black
		get_uncle.color_black

		# Color Node’s grandfather red
		@parent.parent.color_red
	end

	# -- Case 2: node’s uncle is black, node is a right child --
	# Rotate left around nodes’s father
	# Continue to case 3
	def case2_correct
		return if get_uncle.nil? || uncle_is_red?
		return if @parent.right != self

		# Rotate left around nodes’s father
		father, @parent = @parent, @parent.parent
		father.righ, father.parent = left, self
		left = father

		# Continue to case 3
		case3_correct
	end

	# -- Case 3: node’s uncle is black, node is a left child --
	# Rotate right around nodes’s grandfather
	# Switch colors between node’s father and nodes’s (new) sibling
	def case3_correct
		return if @parent.nil? || @parent.parent.nil?

		self_is_left_leaf = (@parent.left == self)
		return if !self_is_left_leaf

		# Rotate right around nodes’s grandfather
		father = @parent
		grandfather = @parent.parent

		new_right_node = RedBlackBinaryTreeNode.new(grandfather)
		new_right_node.value = grandfather.value
		new_right_node.left = father.right
		new_right_node.right = grandfather.right

		grandfather.value = father.value
		grandfather.left = father.left
		grandfather.right = new_right_node

		# Switch colors between node’s father and nodes’s (new) sibling
		grandfather.color_black
		grandfather.right.color_red
	end

	def initialize_node(value)
		@value = value

		@left = RedBlackBinaryTreeNode.new(self)
		@right = RedBlackBinaryTreeNode.new(self)

		# Root node is always black, new inserted node always red
		if @parent.nil?
			@is_red = false
		else
			@is_red = true
		end

		correct_tree

		true
	end
	
end