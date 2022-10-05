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
  has_many :documents
  has_many :articles
  has_many :notifications
  has_many :tutorials
  has_many :videos


  def is_student?
    role.code == 'STU'
  end

  def is_hod?
    role.code == 'HOD'
  end

  def is_faculty?
    role.code == 'FAC'
  end
end
