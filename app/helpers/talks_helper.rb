module TalksHelper
  def wiki(word)
    require 'json'
    require 'open-uri'
    require 'net/http'

    api_url = "https://simple.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro=&explaintext=&titles=#{word}"
    uri = URI.parse(api_url)

    header = {'Content-Type': 'application/json'}

    # Create the HTTP objects
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, header)

    # Send the request
    response = http.request(request)
    JSON.parse(response.body).values[1]['pages'].values[0]['extract'].to_s
  end

  def parent_talk(sub_id)
    parent_id = Talk.find(sub_id).from
    @parent_ids << sub_id
    if parent_id.present?
      @parent_ids << parent_id
      parent_talk(parent_id)
    else
      ids = @parent_ids
      @parent_ids =[]
      Talk.where(id: ids).pluck(:id, :topic)
    end
  end
end
