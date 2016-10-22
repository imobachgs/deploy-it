class Machine < ApplicationRecord
  has_many :projects

  validates :name,         presence: true
  validates :ip,           presence: true
end
