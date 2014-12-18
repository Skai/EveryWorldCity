include ApplicationHelper

class City < ActiveRecord::Base
  default_scope ->                { where.not(:wiki_page_id => nil) }
  default_scope ->                { where.not(:wiki_page_id => -1) }
  scope :wiki_page_blank, ->      { where(:wiki_page_id => nil) }
  scope :wiki_page_not_blank, ->  { where.not(:wiki_page_id => nil) }
  scope :wiki_page_not_exists, -> { where(:wiki_page_id => -1) }
  scope :is_twitted, ->           { where(:is_in_twitter => true) }
  scope :is_twitted, ->           { where.not(:sent_at => nil) }
  scope :is_not_twitted, ->       { where(:is_in_twitter => false, :sent_at => nil) }
  scope :will_be_twitted, ->      { where(:is_in_twitter => true, :sent_at => nil)}
  
  before_save :check_twitter_image
  attr_writer :remove_twitter_image
  has_attached_file :twitter_image, :styles => { 
    :medium => "1600x1600>", 
    :thumb => "300x300>"
  }, 
  :default_url => "/missing.png",
  :path => ":rails_root/public/images/:id/:style/:filename",
  :url => "/images/:id/:style/:filename"
 
  validates_attachment_content_type :twitter_image, content_type: /\Aimage\/.*\Z/
  
  def remove_twitter_image
    @remove_twitter_image || false
  end
 
  def check_twitter_image
    self.twitter_image=nil if self.remove_twitter_image == "1"
  end 

  def to_param
    "#{self.friendly_url}"
  end

  def self.random
    self.limit(1).order('RANDOM()').first
  end
  
  def set_city_for_twitter
    self.is_in_twitter = true
    self.save
  end
end
