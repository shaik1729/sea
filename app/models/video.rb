class Video < ApplicationRecord
    belongs_to :tutorial
    belongs_to :user

    has_rich_text :content
    has_one_attached :clip
    has_one_attached :thumbnail

    before_save :upcase_fields

    validates :title, presence: true
    validates :content, presence: true
    validates :tutorial_id, presence: true
    validates :user_id, presence: true

    def upcase_fields
        self.title.upcase!
    end

end
