FactoryBot.define do
  factory :access_token, class: 'Doorkeeper::AccessToken'  do
    association :application, factory: :oauth_application
    resource_owner_id { create(:user).id }
  end
end