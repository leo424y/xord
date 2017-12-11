require 'rails_helper'

RSpec.describe Talk, type: :model do
  # 常數 constant
  # 關聯 associations
  # 驗證 validations
  # Scope
  # 類別方法 class method
  # 實體方法 instance method
  describe "#parent_talk" do
    it "return right content" do
      expect(Talk.parent_talk).to include("dog")
      Talk.delet_all
    end
  end
end
