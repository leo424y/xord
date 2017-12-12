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
      expect(wiki('愛')).to include("愛,")
    end
  end
  context "#wiki_url" do
    it "return right url" do
      expect(wiki_url('english', 'url')).to include("en")
      expect(wiki_url('english', 'json')).not_to include("tw")
    end
  end
end
