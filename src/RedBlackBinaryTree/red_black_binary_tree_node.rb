class RedBlackBinaryTreeNode
	attr_reader :value, :left, :right, :parent, :is_red
	attr_writer :value, :left, :right, :parent

	LEFT = 1
	RIGHT = 2

	def initialize(parent_node)
		@parent, @value, @is_red = parent_node, nil, false
		@left, @right = nil, nil
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

	def depth(level=0)
		return level if @value.nil?

		level += 1

		[@left.depth(level), @right.depth(level)].max
	end


	def correct_tree
		if @parent.nil?
			color_black
		end

		return false if @parent.nil? || @parent.parent.nil? || @parent.is_black? || is_black?

		if get_uncle.is_red?
			case1_correct
		else
			# Case2 or Case3
			grandfather = @parent.parent
			father = @parent

			is_left_left   = (grandfather.left == father)  && (father.left == self)
			is_right_right = (grandfather.right == father) && (father.right == self)

			is_left_right  = (grandfather.left == father)  && (father.right == self)
			is_right_left  = (grandfather.right == father) && (father.left == self)
			
			if is_left_left
				case3_correct(LEFT)
			elsif is_right_right
				case3_correct(RIGHT)
			elsif is_left_right
				case2_correct(LEFT)
			elsif is_right_left				
				case2_correct(RIGHT)
			end
		end

		
	end

	private
	# 
	# PRIVATE METHODS
	# 

	# -- Case 1: node’s uncle is red --
	# Color Node’s father and uncle black
	# Color Node’s grandfather red
	def case1_correct
		# Color Node’s father and uncle black
		@parent.color_black
		get_uncle.color_black

		# Color Node’s grandfather red
		@parent.parent.color_red

		# Correct one level up if there is binary tree violation
		@parent.parent.correct_tree

		true
	end

	# -- Case 2: node’s uncle is black, node is a right child --
	# Rotate left around nodes’s father
	# Continue to case 3
	def case2_correct(side)
		father = @parent

		# Rotate left around nodes’s father
		if side == LEFT
			new_left = RedBlackBinaryTreeNode.new(father)
			new_left.color_red
			new_left.value = father.value
			new_left.left = father.left
			new_left.right = father.right.left
			new_left.left.parent, new_left.right.parent = new_left, new_left

			father.value = @value
			father.left = new_left
			father.right = father.right.right
			father.right.parent = father
		else
			new_right = RedBlackBinaryTreeNode.new(father)
			new_right.color_red
			new_right.value = father.value
			new_right.left = father.left.right
			new_right.right = father.right
			new_right.left.parent, new_right.right.parent = new_right, new_right

			father.value = @value
			father.right = new_right
			father.left = father.left.left
			father.left.parent = father			
		end

		# Continue to case 3
		case3_correct(side)
	end

	# -- Case 3: node’s uncle is black, node is a left child --
	# Rotate right around nodes’s grandfather
	# Switch colors between node’s father and nodes’s (new) sibling
	def case3_correct(side)
		father = @parent
		grandfather = @parent.parent

		if side == LEFT
			# Rotate right around nodes’s grandfather
			new_right_node = RedBlackBinaryTreeNode.new(grandfather)
			new_right_node.color_red
			new_right_node.value = grandfather.value
			new_right_node.left  = father.right
			new_right_node.left.parent = new_right_node
			new_right_node.right = grandfather.right
			new_right_node.right.parent = new_right_node

			grandfather.value = father.value
			grandfather.left = father.left
			grandfather.left.parent = grandfather
			grandfather.right = new_right_node

			# Switch colors between node’s father and nodes’s (new) sibling
			grandfather.color_black
			grandfather.right.color_red
		else
			# Rotate left around nodes’s grandfather
			new_left_node = RedBlackBinaryTreeNode.new(grandfather)
			new_left_node.color_red
			new_left_node.value = grandfather.value
			new_left_node.right = father.left
			new_left_node.right.parent = new_left_node
			new_left_node.left = grandfather.left
			new_left_node.left.parent = new_left_node

			grandfather.value = father.value
			grandfather.right = father.right
			grandfather.right.parent = grandfather
			grandfather.left = new_left_node

			# Switch colors between node’s father and nodes’s (new) sibling
			grandfather.color_black
			grandfather.left.color_red
		end

		true
	end

	def initialize_node(value)
		@value = value

		@left = RedBlackBinaryTreeNode.new(self)
		@right = RedBlackBinaryTreeNode.new(self)

		# Root node is always black and new inserted node always red
		if @parent.nil?
			@is_red = false
		else
			@is_red = true

			correct_tree
		end

		true
	end
	
end