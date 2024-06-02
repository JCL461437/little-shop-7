FactoryBot.define do
  factory :invoice do
    customer
    status { rand(0..2) }
  end
end