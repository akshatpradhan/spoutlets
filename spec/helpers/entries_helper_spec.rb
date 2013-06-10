require 'spec_helper'

describe EntriesHelper do

  context "mental state" do

    it "should be 20 times the mental state value" do
      width = helper.width_for 5
      expect(width).to eq 100
    end

  end

end
