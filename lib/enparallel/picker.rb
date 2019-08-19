module Enparallel
    class Picker
        def initialize(items, rule)
            if rule == :random
                items.shuffle!
            end

            @items = items
            @i = -1
        end

        def next
            @items[next_index]
        end

        def next_index
            @i += 1
        end
    end
end
