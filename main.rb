module Enumerable
  def my_each
    for x in 0...self.length
      yield(self[x])
    end
  end

  def my_each_with_index
    for x in x...self.size
      yield(self[x], x)
    end
  end

  def my_select
    n_arr = []
    self.my_each do |y|
      n_arr.push(y) if yield(y)
    end
    n_arr
  end

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

  
end