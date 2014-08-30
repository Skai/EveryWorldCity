namespace :delayed do
  desc "Task for twitting city and adding flag for future tweet."
  task tweet: :environment do 
    #Tweet city
    tweet(City.will_be_twitted.first)
    #Set flag for city wich will be twitted the next day.
    City.random.set_city_for_twitter
  end
end