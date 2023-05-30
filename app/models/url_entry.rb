class UrlEntry < ApplicationRecord

    def increment
        new_count = self.counter + 1
        self.update(counter: new_count)
    end

end
