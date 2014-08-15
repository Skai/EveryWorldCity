class City < ActiveRecord::Base
  default_scope -> { where.not(:wiki_page_id => nil) }
  default_scope -> { where.not(:wiki_page_id => -1) }

  def to_param
    "#{self.friendly_url}"
  end
end
