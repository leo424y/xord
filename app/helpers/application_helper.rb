module ApplicationHelper
  def link_by_topic(talk)
    new_talk_path(f: talk.id)

    # if (talk.topic.length == talk.topic.bytes.to_a.length) && (talk.topic.length == talk.topic.gsub(/[[:space:]]/, '').length)
    #   "https://simple.wikipedia.org/wiki/#{talk.topic}"
    # elsif (talk.topic.length < 5) && (talk.topic.length == talk.topic.gsub(/[[:space:]]/, '').length)
    #   "https://zh-tw.wikipedia.org/wiki/#{talk.topic}"
    # else
    #   new_talk_path(f: talk.id)
    # end
  end
end
