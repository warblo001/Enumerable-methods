module Enumerable
  def my_each
    x = 0
    new_arr = to_a
    while x < new_arr.length
      yield(new_arr[x])
      x += 1
    end
    self
  end

  def my_each_with_index
    x = 0
    new_arr = to_a
    while x < new_arr.length
      yield(new_arr[x], x)
      x += 1
    end
    self
  end

  def my_select
    new_arr = []
    my_each do |x|
      new_arr.push(x) if yield(x)
    end
    new_arr
  end

## 3. my_select
puts 'my_select'
puts '---------'
p [1, 2, 3, 8].my_select(&:even?) # => [2, 8]
p [0, 2018, 1994, -7].my_select { |n| n > 0 } # => [2018, 1994]
p [6, 11, 13].my_select(&:odd?) # => [11, 13]
p (1..5).my_select(&:odd?) # => [1, 3, 5]
puts
  def my_all?
    x = 0
    while x < self.size
      unless yield(self[x])
        return false
      end
    x += 1
    end
    true
  end

  def my_any?
    result = false
    self.my_each { |tng| result = true if yield(tng)}
    return result
  end

  def my_none?
    result = true
    self.my_each { |tng| result = false if yield(tng)}
    return result
  end

  def my_count(obj=nil)
  count = 0
  
    if block_given?
      self.my_each do |x|
        count += 1 if yield(x)
      end
    elsif obj
      self.my_each do |x|
        count += 1 if x == obj
    end
    else
      count = self.length
    end
  count
  end
end

#p multiply_els([2,4,5]) #=> 40

## 4. my_all? (example test cases)
#puts 'my_all?'
#puts '-------'
#p [3, 5, 7, 11].my_all?(&:odd?) # => true
#p [-8, -9, -6].my_all? { |n| n < 0 } # => true
#p [3, 5, 8, 11].my_all?(&:odd?) # => false
#p [-8, -9, -6, 0].my_all? { |n| n < 0 } # => false
## test cases required by tse reviewer
#p [1, 2, 3, 4, 5].my_all? # => true
#p [1, 2, 3, false].my_all? # => false
#p [1, 2, 3].my_all?(Integer) # => true
#p %w[dog door rod blade].my_all?(/d/) # => true
#p [1, 1, 1].my_all?(1) # => true
#false_block = proc { |n| n<5 }
#p (1..5).my_all?(&false_block) # false
#p [1, 2.2, 3, 0.6].my_all?(Numeric) #=> True
#puts
## 5. my_any? (example test cases)
#puts 'my_any?'
#puts '-------'
#p [7, 10, 4, 5].my_any?(&:even?) # => true
#p %w[q r s i].my_any? { |char| 'aeiou'.include?(char) } # => true
#p [7, 11, 3, 5].my_any?(&:even?) # => false
#p %w[q r s t].my_any? { |char| 'aeiou'.include?(char) } # => false
## test cases required by tse reviewer
#p [3, 5, 4, 11].my_any? # => true
#p "yo? #{[nil, false, nil, false].my_any?}" # => false
#p [1, nil, false].my_any?(1) # => true
#p [1.1, nil, false].my_any?(Numeric) # => true
#p %w[dog door rod blade].my_any?(/z/) # => false
#p [1, 2, 3].my_any?(1) # => true
#p ["a", "cat", "dog"].my_any?('cat') #=>true
#puts
## 6. my_none? (example test cases)
#puts 'my_none?'
#puts '--------'
#p [3, 5, 7, 11].my_none?(&:even?) # => true
#p [1, 2, 3, 4].my_none?{|num| num > 4} #=> true
#p [nil, false, nil, false].my_none? # => true
#p %w[sushi pizza burrito].my_none? { |word| word[0] == 'a' } # => true
#p [3, 5, 4, 7, 11].my_none?(&:even?) # => false
#p %w[asparagus sushi pizza apple burrito].my_none? { |word| word[0] == 'a' } # => false
## test cases required by tse reviewer
#p [1, 2, 3].my_none? # => false
#p [1, 2, 3].my_none?(String) # => true
#p [1, 2, 3, 4, 5].my_none?(2) # => false
#p [1, 2, 3].my_none?(4) # => true
#p %w[sushi pizza burrito].my_none?(/y/) # => true
#puts
## 7. my_count (example test cases)
#puts 'my_count'
#puts '--------'
#p [1, 4, 3, 8].my_count(&:even?) # => 2
#p %w[DANIEL JIA KRITI dave].my_count { |s| s == s.upcase } # => 3
#p %w[daniel jia kriti dave].my_count { |s| s == s.upcase } # => 0
## test cases required by tse reviewer
#p [1, 2, 3].my_count # => 3
#p [1, 1, 1, 2, 3].my_count(1) # => 3
#p (1..3).my_count #=> 3
#puts
## 8. my_map
#puts 'my_map'
#puts '------'
#p [1, 2, 3].my_map { |n| 2 * n } # => [2,4,6]
#p %w[Hey Jude].my_map { |word| word + '?' } # => ["Hey?", "Jude?"]
#p [false, true].my_map(&:!) # => [true, false]
#my_proc = proc { |num| num > 10 }
#p [18, 22, 5, 6].my_map(my_proc) { |num| num < 10 } # => true true false false
#puts
## 9. my_inject
#puts 'my_inject'
#puts '---------'
#p [1, 2, 3, 4].my_inject(10) { |accum, elem| accum + elem } # => 20
#p [1, 2, 3, 4].my_inject { |accum, elem| accum + elem } # => 10
#p [5, 1, 2].my_inject(:+) # => 8
#p [5, 1, 2].my_inject(:*) # => 10
#p (5..10).my_inject(2, :*) # should return 302400
#p (5..10).my_inject(4) { |prod, n| prod * n } # should return 604800
#p (5..10).my_inject 