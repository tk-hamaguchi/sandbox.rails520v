class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :confirmable, :lockable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email,
            uniqueness: { case_sensitive: false },
            length: { maximum: 100 },
            presence: true
end
