ActiveAdmin.register City do
  scope :wiki_page_not_blank
  scope :wiki_page_blank
  scope :wiki_page_not_exists
  scope :is_twitted
  scope :is_not_twitted
  scope :will_be_twitted

  controller do
    defaults finder: :find_by_friendly_url
    def scoped_collection
      City.unscoped
    end
  end

  def to_param
    friendly_url
  end
  
  filter :country
  filter :city
  filter :description
  filter :friendly_url
  filter :wiki_page_id
  filter :created_at
  filter :updated_at
  filter :sent_at
  filter :is_in_twitter

  index do
    selectable_column
    column :country
    column :city
    column :friendly_url
    column :wiki_page_id
    column :created_at
    column :updated_at
    column :is_in_twitter
    actions
  end
  form do |f|
    f.inputs "General" do
      f.input :country, :as => :string
      f.input :city
      f.input :country_code
      f.input :friendly_url
      f.input :altitude
      f.input :latitude
      f.input :longitude
      f.input :is_in_twitter
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
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
end
