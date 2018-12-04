ActiveAdmin.register Ride do
  permit_params :airport, :flighttime, :owner, :ridetime,
                user_ids: []

  form do |f|
    f.inputs
    f.inputs do
      f.input :user_ids, as: :select, input_html: { multiple: true }, collection: User.all
    end
    f.actions
  end
end
