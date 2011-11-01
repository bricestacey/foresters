FactoryGirl.define do
  factory :record do
  end

  factory :court do
    name  "Newton Centre"
    town  "Newton"
    street "123 Park St"
  end

  factory :ethnicity do
    name "Irish"
  end

  factory :name do
    first  'Matthew'
    middle 'Brice'
    last   'Stacey'
    title  'Mr.'
  end
end
