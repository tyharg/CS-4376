class UrlEntry < ApplicationRecord

    scope :active, -> { where(archived: false) }
    scope :sponsored_first, -> { where(sponsored:true).or(where(sponsored:false)).order(sponsored: :desc)}


    def increment
        new_count = self.counter + 1
        self.update(counter: new_count)
    end

end
