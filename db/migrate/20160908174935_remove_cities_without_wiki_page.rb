class RemoveCitiesWithoutWikiPage < ActiveRecord::Migration
  def change
    City.unscoped.wiki_page_not_exists.destroy_all
  end
end
