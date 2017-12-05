module ApplicationHelper
  def only_one_english_word(talk)
    if (talk.topic.length == talk.topic.bytes.to_a.length) && (talk.topic.length == talk.topic.gsub(/[[:space:]]/, '').length)
      "https://simple.wikipedia.org/wiki/#{talk.topic}"
    elsif (talk.topic.length < 5) && (talk.topic.length == talk.topic.gsub(/[[:space:]]/, '').length)
      "https://zh-tw.wikipedia.org/wiki/#{talk.topic}"
    else
      new_talk_path(f: talk.id)
    end
  end
end
