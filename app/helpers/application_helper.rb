module ApplicationHelper
  def only_one_english_word(string)
    (string.length == string.bytes.to_a.length) && (string.length == string.gsub(/[[:space:]]/, '').length)
  end
end
