require "spec_helper"
require './app/helpers/talks_helper.rb'

describe TalksHelper do
  before(:each) do
    RSpec.configure do |c|
      c.include TalksHelper
    end
    extend TalksHelper
  end
  context "#wiki" do
    it "return right content" do
      expect(wiki('dog')).to include("dog")
      expect(wiki('dog')).not_to include("pig")
    end
  end
  context "#wiki_url" do
    it "return right url" do
      expect(wiki_url('english', 'url')).to include("en")
      expect(wiki_url('english', 'json')).not_to include("tw")
    end
  end
  # context "#split_to_words" do
  #   it "return array" do
  #     expect(split_to_words('english')).to include('English')
  #     expect(split_to_words('人名')).to include('人名')
  #   end
  # end
  # context "#split_to_links" do
  #   it "return array" do
  #     expect(split_to_links(split_to_words('english'), 'english')).not_to include(',')
  #     expect(split_to_links(split_to_words('人名'), '人名')).not_to include('，')
  #   end
  # end
end
