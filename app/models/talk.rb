# require 'csv'

class Talk < ApplicationRecord
  # validates_presence_of :topic

  def self.parent_talk
    parent_id = from
    @parent_ids << sub_id
    if parent_id.present?
      @parent_ids << parent_id
      parent_talk(parent_id)
    else
      ids = @parent_ids
      @parent_ids =[]
      where(id: ids).pluck(:id, :topic)
    end
  end
  # def self.to_csv
  #   attributes = %w{topic}
  #
  #   CSV.generate(headers: true) do |csv|
  #     csv << attributes
  #
  #     all.each do |user|
  #       csv << attributes.map{ |attr| user.send(attr) }
  #     end
  #   end
  # end
end
