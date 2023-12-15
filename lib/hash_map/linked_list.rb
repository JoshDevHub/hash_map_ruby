module HashMap
  class LinkedList
    def initialize
      @head = nil
    end

    Node = Struct.new(:key, :value, :next_node) do
      def initialize(key, value, next_node = nil) = super(key, value, next_node)
    end
    private_constant :Node

    def append(key, value)
      new_node = Node.new(key, value)
      if @head
        tail = find { |node| node.next_node.nil? }
        tail.next_node = new_node
      else
        @head = new_node
      end
    end

    def find_entry(key)
      find { |node| node.key == key }
    end

    def remove(key)
      (@head&.key == key) ? delete_head : delete_node_with_predecessor(key)
    end

    def traverse
      current_pointer = @head

      while current_pointer
        yield(current_pointer)
        current_pointer = current_pointer.next_node
      end
    end

    private

    def delete_head
      target = @head
      @head = @head.next_node
      target.value
    end

    def delete_node_with_predecessor(key)
      predecessor = find { |node| node.next_node&.key == key }
      return if predecessor.nil?

      target = predecessor.next_node
      predecessor.next_node = target.next_node
      target.value
    end

    def find
      traverse { |node| return node if yield(node) }
    end
  end
end
