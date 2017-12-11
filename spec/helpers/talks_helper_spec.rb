require "spec_helper"
require './app/helpers/talks_helper.rb'

describe TalksHelper do
  before(:each) do
    RSpec.configure do |c|
      c.include TalksHelper
    end
    extend TalksHelper
  end
  describe "#wiki" do
    it "return right content" do
      expect(wiki('dog')).to include("dog")
      expect(wiki('dog')).not_to include("pig")
    end
  end
  describe "#parent_talk" do
    it "return right content" do
      expect(parent_talk(1)).to include("dog")
      expect(parent_talk(2)).not_to include("pig")
    end
  end
end
