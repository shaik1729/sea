class Video < ApplicationRecord
    belongs_to :tutorial
    belongs_to :user

    has_rich_text :content
    has_one_attached :clip
    has_one_attached :thumbnail

    before_save :upcase_fields

    def upcase_fields
        self.title.upcase!
    end

end
