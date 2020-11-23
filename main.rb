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

  
end