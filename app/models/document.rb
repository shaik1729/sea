class Document < ApplicationRecord
    has_rich_text :content
    belongs_to :user
    before_save :upcase_fields
    has_many :comments, as: :commentable
    
    APPROVED = 'Approved'
    IN_REVIEW = 'In Review'
    REJECTED = 'Rejected'

    validates :title, presence: true
    validates :keywords, presence: true
    validates :content, presence: true
    validates :user_id, presence: true

    belongs_to :reviewer1, class_name: 'User', foreign_key: 'reviewer1_id', optional: true
    belongs_to :reviewer2, class_name: 'User', foreign_key: 'reviewer2_id', optional: true
    belongs_to :reviewer3, class_name: 'User', foreign_key: 'reviewer3_id', optional: true

    def upcase_fields
        self.title.upcase!
    end
end
