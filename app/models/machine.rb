class Machine < ApplicationRecord
  belongs_to :user

  validates :user_id, :name, :ip, presence: true
end
