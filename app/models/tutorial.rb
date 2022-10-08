class Tutorial < ApplicationRecord
    belongs_to :user
    has_many :videos

    before_save :upcase_fields

    def upcase_fields
        self.title.upcase!
    end
end
