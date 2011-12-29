Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?
    provider :facebook, '300857556614018', 'd6caee5bc42d9358507ffa597422be07', :scope => 'email'
  else
    provider :facebook, '195519233854114', 'dbe88f55b3ea0616733205d457f1e723', :scope => 'email'
  end
end