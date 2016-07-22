require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
    @size = 0
  end

  def count
    @size
  end

  def get(key)
    val = nil
    unless @map.include?(key)
      val = calc_value(key)

      to_insert = Link.new(key, val)
      insert_link(to_insert)

      @map.set(key,to_insert)
      @size += 1

      eject! if count > @max
    else
      update_link!(@map.get(key))
      val = @map.get(key).val
    end
    val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc_value(key)
    # suggested helper method; insert an (un-cached) key
    @prc.call(key)
  end

  def insert_link(to_insert)
    to_insert.prev = @store.last
    to_insert.next = @store.tail
    @store.last.next = to_insert
    @store.tail.prev = to_insert
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    link.prev.next = link.next
    link.next.prev = link.prev
    @store.last.next = link
    link.prev = @store.last
    @store.tail.prev = link
    link.next = @store.tail
  end

  def eject!
    to_eject = @store.first
    @store.head.next = to_eject.next
    to_eject.next.prev = @store.head
    @map.delete(to_eject.key)
    @size -= 1
  end
end
