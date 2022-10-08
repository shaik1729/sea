class Regulation < ApplicationRecord
    has_many :users
    has_many :notifications
    has_many :results
end
