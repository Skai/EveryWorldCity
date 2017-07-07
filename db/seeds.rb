# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
country = Country.create(
  name: 'Ukraine',
  code: 'ua'
)

City.create(
  country: country,
  city: "Kiev",
  latitude: 50.4333333,
  longitude: 30.5166664,
  altitude: 169.0,
  description: "<p><b>Kiev</b> or <b>Kyiv</b> (Ukrainian: Київ [ˈkɨjiv̥]; Russian: Киев [`kʲijɪf]) is the capital and the largest city of Ukraine, located in the north central part of the country on the Dnieper River. The population in July 2013 was 70062847200000000002,847,200 (though higher estimated numbers have been cited in the press), making Kiev the 8th largest city in Europe.</p>",
  is_in_twitter: true,
  sent_at: nil,
  wiki_page_id: 585629,
  wiki_image_src: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Collage_of_Kiev.png/672px-Collage_of_Kiev.png",
  friendly_url: "ukraine-kiev",
  copyright_text: nil,
  twitter_image_file_name: nil,
  twitter_image_content_type: nil,
  twitter_image_file_size: nil,
  twitter_image_updated_at: nil
)
