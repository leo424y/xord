require 'rails_helper'

RSpec.describe ApplicationHelper do
  include ApplicationHelper
  before(:all) {@talk_id = 1}
  # it { link_by_topic(f: @talk_id).should == "/talks/new" }
end
