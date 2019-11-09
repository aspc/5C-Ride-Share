ActiveAdmin.register Ride do
  belongs_to :user, optional: true

  permit_params :airport, :flighttime, :owner_id, :ridetime, :is_aspc, :terminal,
                user_ids: []

  sidebar "Nested Resources", only: [:show, :edit] do
    ul do
      li link_to "Riders",    admin_ride_users_path(resource)
    end
  end

  show do
    attributes_table do
      default_attribute_table_rows.each do |field|
        row field
      end
    end

    panel "Riders" do
      table_for ride.users do |user|
        column do |user| link_to user.name, admin_user_path(user) end
      end
    end

    active_admin_comments
  end

  form do |f|
    f.inputs
    f.inputs do
      f.input :user_ids, as: :select, input_html: { multiple: true }, collection: User.all
    end
    f.actions
  end
end
