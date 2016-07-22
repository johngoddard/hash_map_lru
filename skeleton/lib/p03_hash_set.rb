require_relative 'p02_hashing'
require "byebug"

class HashSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)

     debugger if key == :second
    unless include?(key)
      resize! if @count == num_buckets
      self[key] << key
      @count += 1
    end
  end

  def remove(key)
    if include?(key)
      self[key].delete(key)
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  private

  def [](key)
    # optional but useful; return the bucket corresponding to `num`
    num = key.hash
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_buckets = num_buckets * 2
    new_store = Array.new(new_buckets){Array.new}

    @store.each do |bucket|
      bucket.each do |el|
        new_store[el.hash % new_buckets] << el
      end
    end

    @store = new_store
  end
end
