FactoryGirl.define do
  factory :machine do
    user
    ip        '198.168.3.210'
    name      'Awesome Machine'
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
