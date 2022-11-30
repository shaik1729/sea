class Member < ApplicationRecord
    has_rich_text :content
    has_one_attached :image
end
