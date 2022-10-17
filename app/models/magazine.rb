class Magazine < ApplicationRecord

    validates :title, presence: true
    validates :url, presence: true
    validates :url, uniqueness: true

    before_save :upcase_fields

    def upcase_fields
        self.title.upcase!
    end
end
