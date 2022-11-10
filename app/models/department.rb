class Department < ApplicationRecord
    has_many :users
    has_many :notifications
    has_many :results
    has_one_attached :logo
end
