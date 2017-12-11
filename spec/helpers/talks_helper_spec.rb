require "spec_helper"
require './app/helpers/talks_helper.rb'

RSpec.configure do |c|
  c.include TalksHelper
end
describe TalksHelper do
  describe "#wiki" do
    before(:each) do
      extend TalksHelper
    end
    it "return right content" do
      expect(wiki('dog')).to include("dog")
      expect(wiki('dog')).not_to include("pig")
    end
  end
end
