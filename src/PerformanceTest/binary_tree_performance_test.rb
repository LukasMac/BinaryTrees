require "benchmark"
require_relative "../BinaryTree/binary_tree"

class BinaryTreePerformanceTest
	def initialize
		@binary_tree = BinaryTree.new
		@hash = Hash.new
	end

	def read_from_file(filename)
		raise IOError unless File.exist? filename

		File.open(filename, "r") do |file|
			number = file.gets.to_i

			set_value(number)
		end		
	end

	def test_search(searches_query_count, max_number = 1000000)
		search_values = []

		searches_query_count.times { search_values << rand(max_number) }

		Benchmark.bm(14) do |x|
		  x.report("binary tree:")   { search_values.each do |number| @binary_tree.search(number) end; }
		  x.report("hash:") 				 { search_values.each do |number| @hash[number] end; }
		end
	end

	private

	def set_value(number)
		@binary_tree.insert(number)
		@hash[number] = true
	end
end

performance_test = BinaryTreePerformanceTest.new

performance_test.read_from_file('file_with_8000000_numbers.txt')

performance_test.test_search(10 ** 7)