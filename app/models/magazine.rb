class Magazine < ApplicationRecord
    before_save :upcase_fields

    def upcase_fields
        self.title.upcase!
    end
end
