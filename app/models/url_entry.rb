class UrlEntry < ApplicationRecord

    scope :active, -> { where(archived: false) }

    def increment
        new_count = self.counter + 1
        self.update(counter: new_count)
    end

end
