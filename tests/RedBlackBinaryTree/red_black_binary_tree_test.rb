require "test/unit"
require_relative "../../src/RedBlackBinaryTree/red_black_binary_tree"

class ReadBlackBinaryTreeTest < Test::Unit::TestCase

	def empty_red_black_binary_tree
		RedBlackBinaryTree.new
	end

	def setup
		@binary_tree = empty_red_black_binary_tree		
	end

	def teardown
		@binary_tree = nil
	end

	def test_insert_single_node_tree
		# Create single node tree
		@binary_tree.insert(1)

		# Test tree structure
		assert_equal(1, @binary_tree.root.value, "Root value should be 1")

		# Test tree colors
		assert_equal(true, @binary_tree.root.is_black?, "Root color should be black")
	end

	def test_insert_balanced_three_node_tree
		# Create three node binary tree.
		#   r - stands for red
		#   b - stands for black
		# 
		#      1b
		#     /  \
		#    0r   2r
		@binary_tree.insert(1)
		@binary_tree.insert(0)
		@binary_tree.insert(2)

		# Test tree structure
		assert_equal(1, @binary_tree.root.value, "Root value should be 1")
		assert_equal(0, @binary_tree.root.left.value, "Root's left value should be 0")
		assert_equal(2, @binary_tree.root.right.value, "Root's right value should be 0")

		# Test tree colors
		assert_equal(true, @binary_tree.root.is_black?, "Root color should be black")
		assert_equal(true, @binary_tree.root.left.is_red?, "Root's left leaf color should be red")
		assert_equal(true, @binary_tree.root.right.is_red?, "Root's right leaf color should be red")
	end

	def test_insert_balanced_four_node_tree
		@binary_tree.insert(1)
		@binary_tree.insert(0)
		@binary_tree.insert(2)
	  @binary_tree.insert(3)

		# Created this binary tree.
		#   r - stands for red
		#   b - stands for black
		# 
		#      1b
		#     /  \
		#    0b   2b
		#          \
		#           3r

		# Test tree structure
		assert_equal(1, @binary_tree.root.value, "Root value should be 1")
		assert_equal(0, @binary_tree.root.left.value, "Root's left value should be 0")
		assert_equal(2, @binary_tree.root.right.value, "Root's right value should be 2")
		assert_equal(3, @binary_tree.root.right.right.value, "Root's right leaf's right value should be 3")

		# Test tree colors
		assert_equal(true, @binary_tree.root.is_black?, "Root color should to be black")
		assert_equal(true, @binary_tree.root.right.is_black?, "Root's right leaf color should be black")
		assert_equal(true, @binary_tree.root.left.is_black?, "Root's left leaf color should be black")
		assert_equal(true, @binary_tree.root.right.right.is_red?, "Root's right leaf's right leaf color should be red")
	end

	def test_insert_not_balanced_three_node_tree_balances_tree
		@binary_tree.insert(3)
		@binary_tree.insert(2)
		@binary_tree.insert(1)

		# Create this binary tree.
		#   r - stands for red
		#   b - stands for black
		# 
		#      3b            2b
		#     /             /  \
		#    2r     =>    1r    3r
		#   /   
		#  1r   

		# Test tree structure
		assert_equal(2, @binary_tree.root.value, "Root value should be 2")
		assert_equal(1, @binary_tree.root.left.value, "Root's left value should be 1")
		assert_equal(3, @binary_tree.root.right.value, "Root's right value should be 3")

		# Test tree colors
		assert_equal(true, @binary_tree.root.is_black?, "Root should be black")
		assert_equal(true, @binary_tree.root.left.is_red?, "Root's left leaf should be red")
		assert_equal(true, @binary_tree.root.right.is_red?, "Root's right leaf should be red")
	end

end