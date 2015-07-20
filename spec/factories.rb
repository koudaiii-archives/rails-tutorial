FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:account_name) { |n| "Person#{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password  "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end

    factory :receive_notifications_by_email do
      receive_notifications_by_email true
    end

  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end

end
