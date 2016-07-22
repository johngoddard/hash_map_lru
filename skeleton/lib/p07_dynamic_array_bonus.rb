class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    return nil if i > @store.length-1 ||  @count +i < 0
    if i < 0
      @store[@count + i]
    else
      @store[i]
    end

  end

  def []=(i, val)
    if i < 0
      @store[@count + i] = val
    else
      if i > @count
        push(nil) until @count == i
        push(val)
      else
        @store[i] = val
      end
    end
  end

  def capacity
    @store.length
  end

  def include?(val)
    each{|el| return true if el == val}
    false
  end

  def push(val)
    resize! if @count == @store.length
    @store[@count] = val
    @count += 1
  end

  def unshift(val)
    resize! if @count == @store.length

    (@count-1).downto(0).each do |i|
      @store[i+1] = @store[i]
    end
    @store[0] = val
    @count += 1
  end

  def pop
    return nil if @count == 0
    @count -= 1
    to_return = @store[@count]
    @store[@count] = nil
    to_return
  end

  def shift
    return nil if @count == 0
    to_return = @store[0]

    (1...@count).each do |idx|
      @store[idx - 1] = @store[idx]
    end

    @store[count - 1] = nil
    @count -= 1

    to_return
  end

  def first
    @store[0]
  end

  def last
    @store[@count - 1]
  end

  def each
    (0...@count).each do |idx|
      yield(@store[idx])
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)

    (0...@count).each do |idx|
      return false unless @store[idx] == other[idx]
    end

  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_capacity = @count * 2
    new_store = StaticArray.new(new_capacity)

    (0...@count).each do |i|
      new_store[i] = @store[i]
    end

    @store = new_store
  end
end
