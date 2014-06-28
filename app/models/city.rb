class City < ActiveRecord::Base
  def to_param
    "#{country.parameterize}-#{city.parameterize}"
  end
end
