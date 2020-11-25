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
      my_select { |x| count += 1 if yield(x) }
      count
    else
      return (my_select { |x| x == arg[0] }).length if arg != []

      size
    end
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

  def my_map(proc = nil)
    new_arr = []
    my_select { |x| new_arr.push(yield(x)) } if proc.nil?
    my_select { |x| new_arr.push(proc.call(x)) } unless proc.nil?
    new_arr
  end

  def my_inject(arg = nil, sym = nil)
    if (arg.is_a?(Symbol) || arg.is_a?(String)) && (!arg.nil? && sym.nil?)
      sym = arg
      arg = nil
    end

    if !block_given? && !sym.nil?
      my_each { |x| arg = arg.nil? ? x : arg.send(sym, x) }
    else
      my_each { |x| arg = arg.nil? ? x : yield(arg, x) }
    end
    arg
  end
end

def multiply_els(array)
  array.my_inject(1) { |tot, item| tot * item }
end

# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity