class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_sum = 0
    self.each_with_index do |el, indx|
      hash_sum += el.hash * (indx +1)
    end

    hash_sum * 9973
  end
end

class String
  def hash
    hash_sum = 0
    nums = self.chars.map { |char| char.ord }
    nums.each_with_index do |num, indx|
      hash_sum += num * (indx+1)
    end
    hash_sum * 9973
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_sum = 0
    self.each do |k, v|
      hash_sum += k.hash * (v.hash)
    end
    hash_sum * 9973
  end
end
