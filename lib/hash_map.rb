require_relative "hash_map/hasher"
require_relative "hash_map/linked_list"

class HashMap
  attr_reader :length

  def initialize
    @buckets = Array.new(INITIAL_CAPACITY)
    @length = 0
  end

  MAX_LOAD_FACTOR = 0.75
  INITIAL_CAPACITY = 16

  def get(key)
    key_index = hash_index(key)
    entry = @buckets[key_index]&.find_entry(key)
    entry&.value
  end
  alias [] get

  def set(key, value)
    key_index = hash_index(key)
    @buckets[key_index] ||= LinkedList.new
    entry = @buckets[key_index].find_entry(key)

    if entry
      entry.value = value
    elsif high_load_factor?
      grow_capacity
      set(key, value)
    else
      @buckets[key_index].prepend(key, value)
      @length += 1
    end
  end
  alias []= set

  def key?(key)
    !!get(key)
  end

  def remove(key)
    key_index = hash_index(key)
    output_value = @buckets[key_index]&.remove(key)
    @length -= 1 if output_value

    output_value
  end

  def clear
    @buckets = Array.new(capacity)
    @length = 0
  end

  def entries
    @buckets.each_with_object([]) do |bucket, array|
      next unless bucket

      bucket.traverse { |entry| array << [entry.key, entry.value] }
    end
  end

  def keys = entries.map(&:first)
  def values = entries.map(&:last)

  private

  def hash_index(key)
    index = Hasher.hash(key) % capacity
    raise ArgumentError if index.negative? || index >= capacity

    index
  end

  def grow_capacity
    current_entries = entries
    @length = 0

    @buckets = Array.new(capacity * 2)
    current_entries.each { |key, value| set(key, value) }
  end

  def capacity = @buckets.size
  def load_factor = length / capacity
  def high_load_factor? = load_factor > MAX_LOAD_FACTOR
end
