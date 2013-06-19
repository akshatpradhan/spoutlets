require 'spec_helper'

describe Entry do
  it { should respond_to :user }
  it { should validate_presence_of :content }
  it { should validate_presence_of :category }

  describe ".fetch_categories" do
    before do
      %w(dreams/sleep sex/relationships work/school).each do |c|
        FactoryGirl.create(:entry, category: c)
      end
    end
    it "should return an array of categories" do
      Entry.all.fetch_categories.should == [["dreams/sleep", 1],
                                            ["sex/relationships", 1],
                                            ["work/school", 1]]
    end
  end

end
