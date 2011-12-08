Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '300857556614018', 'd6caee5bc42d9358507ffa597422be07', :scope => 'email'
end