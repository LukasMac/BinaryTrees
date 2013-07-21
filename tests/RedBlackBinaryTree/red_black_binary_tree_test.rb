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
		assert_equal(2, @binary_tree.root.right.value, "Root's right value should be 2")

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

	def test_insert_balanced_four_node_tree2
		@binary_tree.insert(1)
		@binary_tree.insert(0)
		@binary_tree.insert(2)
	  @binary_tree.insert(-1)

		# Created this binary tree.
		#   r - stands for red
		#   b - stands for black
		# 
		#      1b
		#     /  \
		#    0b   2b
		#   /      
		# -1r       

		# Test tree structure
		assert_equal(1, @binary_tree.root.value, "Root value should be 1")
		assert_equal(0, @binary_tree.root.left.value, "Root's left value should be 0")
		assert_equal(2, @binary_tree.root.right.value, "Root's right value should be 2")
		assert_equal(-1, @binary_tree.root.left.left.value, "Root's left leaf's left value should be -1")

		# Test tree colors
		assert_equal(true, @binary_tree.root.is_black?, "Root color should to be black")
		assert_equal(true, @binary_tree.root.right.is_black?, "Root's right leaf color should be black")
		assert_equal(true, @binary_tree.root.left.is_black?, "Root's left leaf color should be black")
		assert_equal(true, @binary_tree.root.left.left.is_red?, "Root's left leaf's left leaf color should be red")
	end

	def test_insert_not_balanced_tree_with_three_left_nodes_should_balance_tree
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

	def test_insert_not_balanced_tree_with_three_right_nodes_should_balance_tree
		@binary_tree.insert(1)
		@binary_tree.insert(3)
		@binary_tree.insert(5)

		# Create this binary tree.
		#   r - stands for red
		#   b - stands for black
		# 
		#  1b              3b
		#   \             /  \
		#    3r     =>   1r   5r
		#     \           
		#      5r        

		# Test tree structure
		assert_equal(3, @binary_tree.root.value, "Root value should be 3")
		assert_equal(1, @binary_tree.root.left.value, "Root's left value should be 1")
		assert_equal(5, @binary_tree.root.right.value, "Root's right value should be 5")

		# Test tree colors
		assert_equal(true, @binary_tree.root.is_black?, "Root should be black")
		assert_equal(true, @binary_tree.root.left.is_red?, "Root's left leaf should be red")
		assert_equal(true, @binary_tree.root.right.is_red?, "Root's right leaf should be red")
	end

	def test_insert_not_balanced_tree_with_left_right_nodes_should_balance_tree
		@binary_tree.insert(5)
		@binary_tree.insert(2)
		@binary_tree.insert(3)

		# Create this binary tree.
		#   r - stands for red
		#   b - stands for black
		# 
		#     5b           5b         3b
		#    /            /          /  \
		#   2r    =>     3r    =>   2r   5r
		#    \          /  
		#     3r       2r 

		# Test tree structure
		assert_equal(3, @binary_tree.root.value, "Root value should be 3")
		assert_equal(2, @binary_tree.root.left.value, "Root's left value should be 2")
		assert_equal(5, @binary_tree.root.right.value, "Root's right value should be 5")

		# Test tree colors
		assert_equal(true, @binary_tree.root.is_black?, "Root should be black")
		assert_equal(true, @binary_tree.root.left.is_red?, "Root's left leaf should be red")
		assert_equal(true, @binary_tree.root.right.is_red?, "Root's right leaf should be red")
	end

	def test_insert_not_balanced_tree_with_right_left_nodes_should_balance_tree
		@binary_tree.insert(1)
		@binary_tree.insert(5)
		@binary_tree.insert(3)

		# Create this binary tree.
		#   r - stands for red
		#   b - stands for black
		# 
		#   1b          1b             3b
		#    \           \            /  \
		#     5r    =>    3r    =>   1r   5r
		#    /             \  
		#   3r              5r 

		# Test tree structure
		assert_equal(3, @binary_tree.root.value, "Root value should be 3")
		assert_equal(1, @binary_tree.root.left.value, "Root's left value should be 1")
		assert_equal(5, @binary_tree.root.right.value, "Root's right value should be 5")

		# Test tree colors
		assert_equal(true, @binary_tree.root.is_black?, "Root should be black")
		assert_equal(true, @binary_tree.root.left.is_red?, "Root's left leaf should be red")
		assert_equal(true, @binary_tree.root.right.is_red?, "Root's right leaf should be red")
	end

	def test_insert_not_balanced_tree_with_4_nodes_should_balance_tree
		@binary_tree.insert(10)
		@binary_tree.insert(85)
		@binary_tree.insert(15)
		@binary_tree.insert(70)
		@binary_tree.insert(20)
		@binary_tree.insert(60)
		@binary_tree.insert(30)
		@binary_tree.insert(50)
		@binary_tree.insert(65)
		@binary_tree.insert(80)
		@binary_tree.insert(90)
		@binary_tree.insert(40)
		@binary_tree.insert(5)
		@binary_tree.insert(55)

		# Create this binary tree.
		#   r - stands for red
		#   b - stands for black
		# 
		#   1b             2b              2b
		#    \            /  \            /  \
		#     2r    =>   1r   3r    =>   1b   3b
		#      \               \               \
		#       3r              4r              4r

		# Test tree structure
		assert_equal(30, @binary_tree.root.value, "Root value should be 30")
		# assert_equal(10, @binary_tree.root.left.value, "Root value should be 10")
		# assert_equal(85, @binary_tree.root.right.value, "Root value should be 85")

		# assert_equal(70, @binary_tree.root.right.left.value, "Root's right's left value nil")
		# assert_equal(nil, @binary_tree.root.right.right.value, "Root's right's right value nil")
		
		# assert_equal(85, @binary_tree.root.right.left.parent.value, "Root's right's right value nil")
		# assert_equal(85, @binary_tree.root.right.right.parent.value, "Root's right's right value nil")

		# assert_equal(10, @binary_tree.root.left.left.parent.value, "Root's right's right value nil")
		# assert_equal(10, @binary_tree.root.left.right.parent.value, "Root's right's right value nil")


		# assert_equal(70, @binary_tree.root.right.left.value, "Root value should be 30")
		# assert_equal(10, @binary_tree.root.left.value, "Root's left value should be 1")
		# assert_equal(70, @binary_tree.root.right.value, "Root's right value should be 4")
		# assert_equal(20, @binary_tree.root.right.left.value, "Root's right leaf left value should be 3")
		# assert_equal(85, @binary_tree.root.right.right.value, "Root's right leaf right value should be 5")
		# assert_equal(60, @binary_tree.root.right.left.right.value, "Root's right leaf right value should be 60")

		# Test tree colors
		# assert_equal(true, @binary_tree.root.is_black?, "Root should be black")
		# assert_equal(true, @binary_tree.root.left.is_black?, "Root's left leaf should be red")
		# assert_equal(true, @binary_tree.root.right.is_black?, "Root's right leaf should be red")
		# assert_equal(true, @binary_tree.root.right.left.is_red?, "Root's right leaf should be red")



		# assert_equal(10, @binary_tree.root.value)
		# assert_equal(nil, @binary_tree.root.left.value)
		# assert_equal(15, @binary_tree.root.right.value)
		# assert_equal(85, @binary_tree.root.right.right.value)
		# assert_equal(nil, @binary_tree.root.right.left.value)
		# assert_equal(nil, @binary_tree.root.right.right.left.value)

		# assert_equal(85, @binary_tree.root.right.right.left.parent.value)
		# assert_equal(85, @binary_tree.root.right.right.right.parent.value)


		# assert_equal(true, @binary_tree.root.is_black?, "Root should be black")
		# assert_equal(true, @binary_tree.root.right.is_red?, "Root should be red")
		# assert_equal(true, @binary_tree.root.right.right.is_red?, "Root should be red")
	end

	def test_acceptance_insert_not_balanced_tree
	 	[10, 85, 15, 70, 20, 60, 30, 50, 65, 80, 90, 40, 5, 55].each do |number|
	 		@binary_tree.insert(number)
	 	end

		# Create this binary tree.
		#   r - stands for red
		#   b - stands for black
		# 
		#                   30b
		#                /      \
		#             15b         70b
		#            /  \       /    \
		#          10b  20b   60r     85b
		#          /         /   \    /  \
		# 		    5r       50b  65b  80r  90r
		#                 /  \
		#               40r  55r


		# Test tree structure
		assert_equal(30, @binary_tree.root.value, "Root value should be 30")

		assert_equal(15, @binary_tree.root.left.value, "Root's left value should be 15")
 		assert_equal(10, @binary_tree.root.left.left.value, "Root's right value should be 10")
		assert_equal(5,  @binary_tree.root.left.left.left.value, "Root's right value should be 5")

		assert_equal(70, @binary_tree.root.right.value, "Root's right value should be 70")
		assert_equal(85, @binary_tree.root.right.right.value, "Root's right value should be 85")
		assert_equal(90, @binary_tree.root.right.right.right.value, "Root's right value should be 90")

		# Test tree colors
		assert_equal(true, @binary_tree.root.is_black?, "Root should be black")
		assert_equal(true, @binary_tree.root.left.is_black?, "Root's left leaf should be red")
		assert_equal(true, @binary_tree.root.left.left.is_black?, "Root's right leaf should be red")
		assert_equal(true, @binary_tree.root.left.left.left.is_red?, "Root's right leaf should be red")
	end

end