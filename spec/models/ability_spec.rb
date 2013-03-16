require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  context "non-admin user" do
    specify "can view herself" do
      user = FactoryGirl.build :user
      ability = Ability.new(user)
      ability.should be_able_to(:view, user)
    end

    specify "cannot view another user" do
      user = FactoryGirl.build :user
      ability = Ability.new(user)
      ability.should_not be_able_to(:view, FactoryGirl.build(:user))
    end
  end

  context "admin user" do
    specify "can view herself" do
      user = FactoryGirl.build :user
      user.add_role :admin
      ability = Ability.new(user)
      ability.should be_able_to(:view, user)
    end

    specify "can view another user" do
      user = FactoryGirl.build :user
      user.add_role :admin
      ability = Ability.new(user)
      ability.should be_able_to(:view, FactoryGirl.build(:user))
    end
  end
end
