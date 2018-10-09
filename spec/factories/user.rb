# This will guess the User class
FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password'}
    # admin { false }

    after :create do |user|
      user.confirm
    end
  end

  factory :admin, class: User do
    sequence(:email) { |n| "admin#{n}@exhibition.com" }
    password { 'password'}
    # admin { true }

    after :create do |admin|
      admin.confirm
    end
  end
end