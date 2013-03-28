require 'spec_helper'

describe User do

  context "entries" do
    
    let(:user_with_entries) { FactoryGirl.create(:end_user) }
    let(:user_without_entries) { FactoryGirl.create(:end_user) }

    before do
      @entries = ["Way too nuclear", "Higgs boson is here","Graphene is the super capacitor"].collect do |content|
        FactoryGirl.create(:published_entry, :user => user_with_entries, :content => content)
      end
    end

    it "can be multiple in number" do
      expect(user_with_entries.entries).to match_array @entries
    end

    it "may not exist" do
      expect(user_without_entries.entries).to be_blank
    end

  end


end
