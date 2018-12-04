ActiveAdmin.register User do
  permit_params :name, :email, :email_pref, :is_cas_authenticated, :is_admin, :school

  form do |f|
    f.semantic_errors
    f.inputs :name, :email, :email_pref, :is_cas_authenticated, :is_admin, :school
    f.actions
  end
end
