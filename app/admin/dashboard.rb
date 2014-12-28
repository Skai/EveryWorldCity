include ApplicationHelper

ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  controller do
    def tweet_now
      #call ApplicationHelper
      tweet(City.will_be_twitted.first)
      redirect_to(:action=>'index')
    end
  end

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recent Tweets" do
          ul do
            City.is_twitted.limit(15).map do |city|
              li link_to([city.city, city.country].join(', '), city_path(city))
            end
          end
        end
        #panel "EveryWorldCity" do
        #  para %(Currently deployed: #{`git describe --tags --abbrev=0`}, #{link_to(`git rev-parse --short HEAD`, "https://github.com/Skai/EveryWorldCity/commit/#{`git rev-parse HEAD`}")}).html_safe
        #end
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
        panel "Tweet Now" do
          button_to "Post New City To Twitter Now", {:action=> :tweet_now}, data: {:confirm => 'Are you sure? It will post new tweet right now!'}
        end
      end
    end
  end # content
end