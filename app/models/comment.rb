class Comment < ApplicationRecord
    belongs_to :commentable, polymorphic: true
    has_many :comments, as: :commentable
    belongs_to :user
    belongs_to :document, optional: true
    belongs_to :article, optional: true

    validates :content, presence: true
    validates :user_id, presence: true
end
