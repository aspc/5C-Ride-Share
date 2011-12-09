Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '195519233854114', 'dbe88f55b3ea0616733205d457f1e723', :scope => 'email'
end