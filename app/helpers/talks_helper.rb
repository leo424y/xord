# require './lib/ckip_client'

module TalksHelper
  def wiki(word)
    require 'json'
    require 'open-uri'
    require 'net/http'

    uri = URI.parse(URI.escape(wiki_url(word, 'json')))

    header = {'Content-Type': 'application/json'}

    # Create the HTTP objects
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, header)

    # Send the request
    response = http.request(request)
    JSON.parse(response.body).values[1] && JSON.parse(response.body).values[1]['pages'].values[0]['extract'].to_s
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

  def wiki_url(word, type)
    word = word.singularize
    lang = lang_is(word)

    if type == 'json'
    # require 'ropencc'
    # word = Ropencc.conv('t2s.json', word)
    "https://#{lang}.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro=&explaintext=&titles=#{word}"
    elsif type == 'url'
      "https://#{lang}.wikipedia.org/wiki/#{word}"
    end
  end

  # def split_to_words(word)
  #   wiki_words = wiki(word)
  #   if lang_is(word) == 'zh' && wiki_words.present?
  #     CKIP.segment( wiki_words.gsub(/[\t<>]/ ,""), 'neat').split('　')
  #   else
  #     wiki_words.split(' ')
  #   end
  # end
  #
  # def split_to_links(words, word)
  #   if lang_is(word) == 'zh'
  #     words.map{ |x| x.gsub(/[\r\n，。；·、]/ ,"") }
  #   else
  #     words.map{ |x| x.gsub(/[,.():{}'"?!]/ ,"").singularize }
  #   end
  # end



  def lang_is(word)
    if word == word.gsub(/[^\w]/, '_')
      'en'
      # 'simple'
    elsif word.contains_ja?
      'ja'
    else
      'zh'
    end
  end
end

class String
  def contains_ja?
    !!(self =~ /\p{Han}|\p{Katakana}|\p{Hiragana}/)
  end
end
