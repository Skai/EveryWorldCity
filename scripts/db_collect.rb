require 'httpclient'
require 'pg'
require 'json'

=begin
    Return true if we got disambiguation page. 
    e.g. title: "Category:Disambiguation pages"
=end
def check_if_disambiguation?(categories)
  return false if categories.nil?
  categories.map do |category|
    return /disambiguation/.match(category['title']) ? true : false
  end 
end

def get_wiki_info_by_title(city)
  #e.g. https://en.wikipedia.org/w/api.php?action=query&titles=Kharkov&format=json&prop=extracts|categories|info|pageimages&pithumbsize=950&redirects=1
  client = HTTPClient.new
  uri = 'https://en.wikipedia.org/w/api.php'
  
  query = {
    'action' => 'query',
    'titles' => city, 
    'format' => 'json',
    'prop' => 'extracts|categories|info|coordinates|pageimages',
    'pithumbsize' => '950', 
    'redirects' => 1
  }

  response = client.get(uri, query)
  response.status == 200 ? JSON.parse(response.body) : false
end

def save_city_info(db_connection, id, params)
  result = db_connection.exec_params(
    'UPDATE cities set(' + params.keys.join(',') + ')=($' + (1..params.keys.size).to_a.join(',$') + ') where id =' + id + ';',
    params.values
  )
end

def collect_wiki_pages (db_connection, limit)
  result = db_connection.exec('SELECT id, city FROM cities where updated_at IS NULL limit ' + limit.to_s)
  
  result.each do |r| 
    wiki_info = get_wiki_info_by_title(r['city'])['query']['pages']
    wiki_page_id = wiki_info.keys[0]
    
    #show some info
    p r['city']
    p wiki_page_id

    unless check_if_disambiguation?(wiki_info[wiki_page_id]['categories'])
      params = {
        'wiki_page_id' => wiki_page_id,
        'description' => wiki_info[wiki_page_id]['extract'],
        'wiki_image_name' => wiki_info[wiki_page_id]['pageimage'],
        'wiki_image_src' => wiki_info[wiki_page_id]['thumbnail'].nil? ? '' : wiki_info[wiki_page_id]['thumbnail']['source'],
        'updated_at' => DateTime.now
      }
    else
      params = {
        'updated_at' => DateTime.now
      }
    end
    save_city_info(db_connection, r['id'], params)
  end
end

#Run the script
db_connection = PG.connect(dbname: 'every_city')
collect_wiki_pages(db_connection, 5000)