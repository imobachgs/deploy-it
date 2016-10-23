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

  def upload_public_key(key, password)
    return false unless ip
    Net::SSH.start(ip, "root", password: password) do |ssh|
      ssh.exec!("mkdir /root/.ssh")
      ssh.scp.upload! StringIO.new(key), "/root/.ssh/authorized_keys"
    end
    true
  rescue
    false
  end
end

# == Schema Information
#
# Table name: machines
#
#  id         :integer          not null, primary key
#  ip         :string           not null
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
