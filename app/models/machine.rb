class Machine < ApplicationRecord
  belongs_to :user
  has_many :assignments

  validates :user_id, :name, :ip, presence: true

  # Check if machine is being used
  #
  # @return [Boolean] true if machine has assignments; false otherwise.
  def assigned?
    assignments.present?
  end
end
