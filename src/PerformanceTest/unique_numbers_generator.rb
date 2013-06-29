class UniqueNumbersGenerator
	
	def generate_numbers(numbers_count)
		@exist = Hash.new

		File.open("file_with_#{numbers_count}_numbers.txt", "w") do |file|
			numbers_count.times {
				begin
					# we double the number for bigger propability to get unique number
					random_number = rand(numbers_count*2)
				end while @exist[random_number]

				@exist[random_number] = true

				file.write("#{random_number}\n")
			}
		end
	end	
	
end

require "benchmark"

time = Benchmark.realtime do
  NumbersGenerator.new.generate_numbers(8000000)
end
puts "Time elapsed #{time*1000} milliseconds"
