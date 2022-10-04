class Batch < ApplicationRecord
    has_many :users
    has_many :notifications
end
