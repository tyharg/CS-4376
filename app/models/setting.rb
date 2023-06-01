class Setting < ApplicationRecord

    def filter_chars_array
        self.filter_chars.split(" ")
    end
end
