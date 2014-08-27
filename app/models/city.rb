class City < ActiveRecord::Base
  default_scope ->                { where.not(:wiki_page_id => nil) }
  default_scope ->                { where.not(:wiki_page_id => -1) }
  scope :wiki_page_blank, ->      { where(:wiki_page_id => nil) }
  scope :wiki_page_not_blank, ->  { where.not(:wiki_page_id => nil) }
  scope :wiki_page_not_exists, -> { where(:wiki_page_id => -1) }
  scope :is_twitted, ->           { where(:is_in_twitter => true) }
  scope :is_twitted, ->           { where.not(:sent_at => nil) }
  scope :is_not_twitted, ->       { where(:is_in_twitter => false, :sent_at => nil) }
  scope :will_be_twitted, ->      {where(:is_in_twitter => true, :sent_at => nil)}

  def to_param
    "#{self.friendly_url}"
  end
end
