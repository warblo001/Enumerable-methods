# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity

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

  def my_all?(*arg)
    if block_given?
      to_a.my_each { |x| return false if yield(x) == false }
      true
    else
      return !(include?(nil) || include?(false)) if arg == []
      return (my_select { |x| x.class <= arg[0] }).length == length if arg[0].is_a? Class
      return (my_select { |x| x.match(arg[0]) }).length == length if arg[0].is_a? Regexp
      return (my_select { |x| x == arg[0] }).length == length if arg[0].class < Numeric
      return (my_select { |x| x == arg[0] }).length == length if arg[0].is_a? String
    end
  end

  def my_any?(*arg)
    if block_given?
      my_each { |item| return true if yield(item) }
      false
    else
      return (my_select { |x| ![nil, false].include?(x) }).length.positive? if arg == []
      return (my_select { |x| x.class <= arg[0] }).length.positive? if arg[0].is_a? Class
      return (my_select { |x| x.match(arg[0]) }).length.positive? if arg[0].is_a? Regexp
      return (my_select { |x| x == arg[0] }).length.positive? if arg[0].class < Numeric
      return (my_select { |x| x == arg[0] }).length.positive? if arg[0].is_a? String
    end
  end

  def my_none?(*arg)
    if block_given?
      my_each { |item| return false if yield(item) }
      true
    else
      return (my_select { |x| ![nil, false].include?(x) }).length.zero? if arg == []
      return (my_select { |x| x.instance_of?(arg[0]) }).length.zero? if arg[0].is_a? Class
      return (my_select { |x| x.match(arg[0]) }).length.zero? if arg[0].is_a? Regexp
      return (my_select { |x| x == arg[0] }).length.zero? if arg[0].class < Numeric
      return (my_select { |x| x == arg[0] }).length.zero? if arg[0].is_a? String
    end
  end

  def my_count(*arg)
    count = 0
    if block_given?
      my_each do |x|
        count += 1 if yield(x)
      end
    elsif arg
      my_each do |x|
        count += 1 if x == arg
      end
    else
      count = length
    end
    count
  end

# 7. my_count (example test cases)
puts 'my_count'
puts '--------'
p [1, 4, 3, 8].my_count(&:even?) # => 2
p %w[DANIEL JIA KRITI dave].my_count { |s| s == s.upcase } # => 3
p %w[daniel jia kriti dave].my_count { |s| s == s.upcase } # => 0
# test cases required by tse reviewer
p [1, 2, 3].my_count # => 3
p [1, 1, 1, 2, 3].my_count(1) # => 3
p (1..3).my_count #=> 3
puts

  
end


# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity