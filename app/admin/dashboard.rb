ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    #div class: "blank_slate_container", id: "dashboard_default_message" do
    #  span class: "blank_slate" do
    #    span I18n.t("active_admin.dashboard_welcome.welcome")
    #    small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #  end
    #end

    columns do
      column do
        panel "Recent Tweets" do
          ul do
            City.is_twitted.limit(15).map do |city|
              li link_to([city.city, city.country].join(', '), city_path(city))
            end
          end
        end
      end

      column do
        panel "Info" do
          para "Cities In Twitter: " + City.is_twitted.count.to_s
        end
        panel "Will be tweeted" do
          ul do
            City.will_be_twitted.map do |city|
              li link_to([city.city, city.country].join(', '), edit_admin_city_path(city))
            end         
          end
        end
      end
    end
  end # content
end