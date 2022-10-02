class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :confirmable, :lockable, :trackable

  belongs_to :role
  belongs_to :department, optional: true
  belongs_to :course, optional: true
  belongs_to :regulation, optional: true
  belongs_to :batch, optional: true
end
