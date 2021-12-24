FactoryBot.define do
  factory :post, :class => Post do
    content{ "test post" }
    user_id {1}
  end
end
