class Tutorial < ApplicationRecord
    belongs_to :user
    has_many :videos
    has_one_attached :thumbnail

    before_save :upcase_fields

    def upcase_fields
        self.title.upcase!
    end
end
