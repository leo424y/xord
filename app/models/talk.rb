# require 'csv'

class Talk < ApplicationRecord
  # validates_presence_of :topic

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
