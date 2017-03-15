FactoryGirl.define do
  factory :user do |f|
    f.email 'test@test.com'
    f.password '12345678'
  end
end
