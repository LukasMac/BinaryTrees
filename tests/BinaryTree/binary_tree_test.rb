require "test/unit"
require_relative "../../src/BinaryTree/binary_tree"

class BinaryTreeTest < Test::Unit::TestCase

	def empty_tree
		BinaryTree.new
	end

	def non_empty_tree
		tree = empty_tree

		tree.insert(1)
		tree.insert(2)
		tree.insert(3)

		tree
	end

	def test_sarch_empty_tree_returns_false
		tree_search = empty_tree.search(1)

		assert_equal false, tree_search
	end

	def test_insert_number_returns_true
		tree_insert = empty_tree.insert(1)

		assert_equal true, tree_insert
	end

	def test_search_existing_number_in_tree_returns_true
		tree_search = non_empty_tree.search(1)

		assert_equal true, tree_search
	end

	def test_search_existing_number_in_tree_returns_true
		tree_search = non_empty_tree.search(2)

		assert_equal true, tree_search
	end

	def test_search_non_existing_number_tree_returns_false
		tree_search = non_empty_tree.search(10)

		assert_equal false, tree_search
	end

	def test_search_inserted_number_returns_true
		tree = empty_tree
		tree.insert(10)
		tree_inserted_search = tree.search(10)

		assert_equal true, tree_inserted_search
	end

	def test_delete_empty_tree_returns_false
		tree_delete = empty_tree.delete(1)
		
		assert_equal false, tree_delete
	end

	def test_delete_existing_number_in_tree_returns_true
		tree_delete = non_empty_tree.delete(1)

		assert_equal true, tree_delete
	end

	def test_delete_non_existing_number_in_tree_returns_false
		tree_delete = non_empty_tree.delete(10)

		assert_equal false, tree_delete
	end

	def test_delete_existing_number_and_search_for_it_returns_false
		tree = non_empty_tree
		tree.delete(1)
		tree_search_deleted = tree.search(1)

		assert_equal false, tree_search_deleted
	end
end