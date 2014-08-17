class City < ActiveRecord::Base
  default_scope -> { where.not(:wiki_page_id => nil) }
  default_scope -> { where.not(:wiki_page_id => -1) }
  scope :wiki_page_blank, -> { where(:wiki_page_id => nil) }
  scope :wiki_page_not_blank, -> { where.not(:wiki_page_id => nil) }
  scope :wiki_page_not_exists, -> { where(:wiki_page_id => -1) }

  def to_param
    "#{self.friendly_url}"
  end
end
