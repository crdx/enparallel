module Enparallel
    class Picker
        def initialize(items, rule)
            if rule == :random
                items.shuffle!
            end

            @items = items
            @i = 0
        end

        def pop
            @items[next_index]
        end

        def next_index
            c = @i
            @i += 1
            c
        end
    end
end
