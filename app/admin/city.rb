ActiveAdmin.register City do
  permit_params :country, :city, :friendly_url, :altitude, :latitude, :longitude, :is_in_twitter, :wiki_page_id, :wiki_image_src, :description
  scope :wiki_page_not_blank
  scope :wiki_page_blank
  scope :wiki_page_not_exists
  scope :is_twitted
  scope :is_not_twitted
  scope :will_be_twitted

  controller do
    #change from using id to using friendly_url
    defaults finder: :find_by_friendly_url
    def scoped_collection
      City.unscoped
    end
  end

  def to_param
    friendly_url
  end
  
  #Filters Section
  filter :country
  filter :city
  filter :description
  filter :friendly_url
  filter :wiki_page_id
  filter :created_at
  filter :updated_at
  filter :sent_at
  filter :is_in_twitter

  #Index view
  index do
    selectable_column
    column :country
    column :city
    column :friendly_url
    column :wiki_page_id
    column :created_at
    column :updated_at
    column :is_in_twitter
    actions do |city|
      link_to "Preview", city, :target => "_blank"
    end
  end

  #City form
  form do |f|
    f.inputs "General" do
      f.input :country, :as => :string
      f.input :city
      f.input :friendly_url
      f.input :altitude
      f.input :latitude
      f.input :longitude
      f.input :is_in_twitter
    end
    f.inputs "Twitter Image" do
      f.form_buffers.last << f.template.image_tag(f.object.wiki_image_src, :height => 600)
    end
    f.inputs "Content" do
      f.input :wiki_page_id
      f.input :wiki_image_src
      f.input :description
    end

    #f.inputs "Tome Box" do
    #  f.input :created_at
    #  f.input :updated_at
    #  f.input :sent_at
    #end
    f.actions
  end
end
