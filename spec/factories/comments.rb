FactoryBot.define do
  factory :comment, :class => Comment do
    content{ "test comment" }
    user_id {1}
  end
end
