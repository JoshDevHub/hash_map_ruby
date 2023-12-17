class HashMap
  module Hasher
    module_function

    PRIME_MULTIPLIER = 31

    def hash(string)
      string.each_char.reduce(0) do |code, char|
        code * PRIME_MULTIPLIER + char.ord
      end
    end
  end

  private_constant :Hasher
end
