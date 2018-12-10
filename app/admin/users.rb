ActiveAdmin.register User do
  belongs_to :ride, optional: true

  permit_params :name, :email, :email_pref, :is_cas_authenticated, :is_admin, :school

  sidebar "Nested Resources", only: [:show, :edit] do
    ul do
      li link_to "Rides",    admin_user_rides_path(resource)
    end
  end

  show do
    attributes_table do
      default_attribute_table_rows.each do |field|
        row field
      end
    end

    panel "Rides" do
      table_for user.rides do |ride|
        column do |ride|
          link_to "Ride at #{ride.ridetime.strftime("%l:%M%P on %B %d, %Y")} for flight at #{(RidesUser.find_by(:user => user, :ride => ride).flighttime || ride.flighttime).strftime("%l:%M%P on %B %d, %Y")}", admin_ride_path(ride)
        end
      end
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors
    f.inputs :name, :email, :email_pref, :is_cas_authenticated, :is_admin, :school
    f.actions
  end
end
