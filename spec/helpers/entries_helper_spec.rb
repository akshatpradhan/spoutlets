require 'spec_helper'

describe EntriesHelper do

  context "emotion level" do

    it "should be 20 times the value" do
      width = helper.width_for 200
      expect(width).to eq 4000
    end

  end

end
