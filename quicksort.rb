class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
		return array if array.length <= 1

		pivot_idx = rand(array.length)
		left, right = [], []

		array.each_with_index do |x, i|
			next if i == pivot_idx

			target = x <= array[pivot_idx] ? left : right
			target.push(x)
		end

		self.sort1(left) + [array[pivot_idx]] + self.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
		return array if length <= 1

		pivot_idx = self.partition(array, start, length, &prc)

		self.sort2!(array, start, pivot_idx - start, &prc)
		self.sort2!(array, pivot_idx + 1, start + length - pivot_idx - 1, &prc)

		array
  end

  def self.partition(array, start, length, &prc)
		prc = Proc.new{|a,b| a <=> b} if prc.nil?

		pivot_idx = start
		array[start + 1...start + length].each_with_index do |x, i|
			if prc.call(array[pivot_idx], x) == 1
				array[pivot_idx], array[i + start + 1], array[pivot_idx + 1] =
					array[i + start + 1], array[pivot_idx + 1], array[pivot_idx]

				pivot_idx += 1
			end
		end

		pivot_idx
  end
end
