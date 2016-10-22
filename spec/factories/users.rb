FactoryGirl.define do
  factory :user, aliases: [:unconfirmed_user] do
    email { [Faker::Internet.email, Faker::Internet.free_email, Faker::Internet.safe_email].sample }
    password { Faker::Internet.password(6) }
    password_confirmation { password }

    factory :confirmed_user do
      confirmed_at { 10.minutes.ago }
    end
  end
end
