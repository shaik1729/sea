class Video < ApplicationRecord
    belongs_to :tutorial
    belongs_to :user

    has_rich_text :content
    has_one_attached :clip
    has_one_attached :thumbnail

end
