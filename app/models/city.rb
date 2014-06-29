class City < ActiveRecord::Base
  def to_param
    "#{self.friendly_url}"
  end
end
