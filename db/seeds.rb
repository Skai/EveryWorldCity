# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
country1 = Country.create(
  name: 'Ukraine',
  code: 'ua'
)

country2 = Country.create(
  name: 'Italy',
  code: 'it'
)

City.create(
  country: country1,
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

City.create(
  country: country2,
  city: "Pisa",
  latitude: 43.7175199,
  longitude: 10.3964996,
  altitude: 1,
  description: "<p><b>Pisa</b> (/ˈpiːzə/; <small>Italian pronunciation: </small>[ˈpiːsa]) is a city in Tuscany, Central Italy, on the right bank of the mouth of the River Arno on the Tyrrhenian Sea. It is the capital city of the Province of Pisa. Although Pisa is known worldwide for its leaning tower (the bell tower of the city's cathedral), the city of over 88,627 residents (around 200,000 with the metropolitan area) contains more than 20 other historic churches, several palaces and various    bridges across the River Arno. Much of the city's architecture was financed from its history as one of the Italian maritime republics.</p>
  <p>The city is also home of the University of Pisa, which has a history going back to the 12th century and also has the mythic Napoleonic Scuola Normale Superiore di Pisa and Sant'Anna School of Advanced Studies as the best sanctioned Superior Graduate Schools in Italy.</p>
  <p></p>
  <h2>History</h2>
  <h3>Ancient times</h3>
  <p>Pisa lies at the junction of two rivers, the Arno and the Serchio, which form a laguna at the Tyrrhenian Sea. The origin of the name, Pisa, is a mystery. While the origin of the city had remained unknown for centuries, the Pelasgi, the Greeks, the Etruscans, and the Ligurians had variously been proposed as founders of the city (for example, a colony of the ancient city of Pisa, Greece). Archaeological remains from the 5th century BC confirmed the existence of a city at the sea, trading with Greeks and Gauls. The presence of an Etruscan necropolis, discovered during excavations in the <i>Arena Garibaldi</i> in 1991, confirmed its Etruscan origins.</p>
  <p>Ancient Roman authors referred to Pisa as an old city. Strabo referred Pisa's origins to the mythical Nestor, king of Pylos, after the fall of Troy. Virgil, in his <i>Aeneid</i>, states that Pisa was already a great center by the times described; the settlers from the Alpheus coast have been credited with the founding of the city in the 'Etruscan lands'. The Virgilian commentator Servius wrote that the Teuti, or Pelops, the king of the Pisaeans, founded the town thirteen centuries before the start of the common era.</p>
  <p>The maritime role of Pisa should have been already prominent if the ancient authorities ascribed to it the invention of the naval ram. Pisa took advantage of being the only port along the western coast from Genoa (then a small village) to Ostia. Pisa served as a base for Roman naval expeditions against Ligurians, Gauls and Carthaginians. In 180 BC, it became a Roman colony under Roman law, as <i>Portus Pisanus</i>. In 89 BC, <i>Portus Pisanus</i> became a municipium. Emperor Augustus fortified the colony into an important port and changed the name in <i>Colonia Iulia obsequens</i>.</p>
  <p>It is supposed that Pisa was founded on the shore. However, due to the alluvial sediments from the Arno and the Serchio, the shore moved west. Strabo states that the city was 2.5 miles (4.0 km) away from the coast. Currently, it is located 6 miles (9.7 km) from the coast. However it was a maritime city, with ships sailing up the Arno.</p>",
  is_in_twitter: true,
  sent_at: nil,
  wiki_page_id: 1,
  wiki_image_src: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/The_Leaning_Tower_of_Pisa_SB.jpeg/624px-The_Leaning_Tower_of_Pisa_SB.jpeg",
  friendly_url: "italy-pisa",
  copyright_text: nil,
  twitter_image_file_name: nil,
  twitter_image_content_type: nil,
  twitter_image_file_size: nil,
  twitter_image_updated_at: nil
)
