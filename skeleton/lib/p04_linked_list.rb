require 'byebug'

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  attr_reader :head, :tail 

  include Enumerable

  def initialize
    @head = Link.new(:head)
    @tail = Link.new(:tail)

    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    current_node = first
    until current_node == @tail
      return current_node.val if current_node.key == key
      current_node = current_node.next
    end
    nil
  end

  def include?(key)
    current_node = first
    until current_node == @tail
      return true if current_node.key == key
      current_node = current_node.next
    end
    false
  end

  def insert(key, val)
    if include?(key)
      current_node = first
      until current_node == @tail
        if current_node.key == key
          current_node.val = val
          break
        end
        current_node = current_node.next
      end
    else
      new_link = Link.new(key,val)
      new_link.prev = last
      new_link.next = @tail
      last.next = new_link
      @tail.prev = new_link
    end
  end

  def remove(key)
    current_node = first

    until current_node == @tail
      if current_node.key == key
        current_node.prev.next = current_node.next
        current_node.next.prev = current_node.prev
        break
      end

      current_node = current_node.next
    end
  end

  def each
    current_node = first

    until current_node == @tail
      yield(current_node) if block_given?
      current_node = current_node.next
    end
  end


  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
