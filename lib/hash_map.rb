require_relative "hash_map/hash_map"
require_relative "hash_map/linked_list"

module HashMap
  module_function

  private_constant :HashMap, :LinkedList

  def new(...) = HashMap.new(...)
end
