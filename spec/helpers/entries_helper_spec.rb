require 'spec_helper'

describe EntriesHelper do

  context "mental state" do

    it "should be 20 times the mental state value" do
      width = helper.width_for 5
      expect(width).to eq 100
    end

  end

  describe "#like_status_for" do
    context "an entry with 0 likes" do
      let!(:entry) {FactoryGirl.create(:entry, user: FactoryGirl.create(:user), likes: 0)}
      context "when the viewing user is the entry creator" do
        it "shows 'No one else knows the feeling'" do
          helper.like_status_for(entry, entry.user)
            .should == "No one else knows the feeling."
        end
      end
      context "when the viewing user is not the entry creator" do
        it "shows 'No one else knows the feeling'" do
          helper.like_status_for(entry, FactoryGirl.create(:user))
            .should == "No one else knows the feeling."
        end
      end
    end
    context "an entry with 1 like" do
      let!(:entry) {FactoryGirl.create(:entry, user: FactoryGirl.create(:user))}
      let!(:user) {FactoryGirl.create(:user)}
      before(:each) do
        entry.like(user)
      end
      context "when the viewing user is the entry creator" do
        it "shows 'Another person knows the feeling'" do
          helper.like_status_for(entry, entry.user)
            .should == "Another person knows the feeling."
        end
      end
      context "when the viewing user is not the entry creator" do
        it "shows 'You know the feeling'" do
          helper.like_status_for(entry, user)
            .should == "You know the feeling."
        end
      end

    end
    context "an entry with N likes" do
      let!(:entry) {FactoryGirl.create(:entry, user: FactoryGirl.create(:user), likes: 5)}
      context "when the viewing user is the entry creator" do
        it "shows 'N others know the feeling'" do
          helper.like_status_for(entry, entry.user)
            .should == "<b>5</b> others know the feeling."
        end
      end
      context "when the viewing user is not the entry creator" do
        it "shows 'You and N others know the feeling'" do
          user = FactoryGirl.create(:user)
          entry.like(user)
          helper.like_status_for(entry, user)
            .should == "You and <b>5</b> others know the feeling."
        end
      end
    end
  end
end
