class Notification < ApplicationRecord
    has_rich_text :content
    belongs_to :user, optional: true
    belongs_to :regulation, optional: true
    belongs_to :batch, optional: true
    belongs_to :department, optional: true
    belongs_to :course, optional: true

    validates :title, presence: true
    validates :content, presence: true
    validates :regulation_id, presence: true
    validates :batch_id, presence: true
    validates :department_id, presence: true
    validates :course_id, presence: true

    before_save :upcase_fields

    def upcase_fields
        self.title.upcase!
    end
end
