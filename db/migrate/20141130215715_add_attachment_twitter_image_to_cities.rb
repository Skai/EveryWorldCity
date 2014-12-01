class AddAttachmentTwitterImageToCities < ActiveRecord::Migration
  def self.up
    change_table :cities do |t|
      t.attachment :twitter_image
    end
  end

  def self.down
    remove_attachment :cities, :twitter_image
  end
end
