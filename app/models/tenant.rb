class Tenant < ApplicationRecord
  validates :name,
            length: { in: 1..40 },
            presence: true

  validates :status,
            presence: true

  enum status: { active: 1, locked: 0, inactive: -1 }
end
