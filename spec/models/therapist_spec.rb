require 'spec_helper'

describe Therapist do

  before(:each) do
    @attr = {
      :name => "Example User",
      :email => "therapist@example.com",
      :password => "changeme",
      :password_confirmation => "changeme"
    }
  end

  it "should create a new instance given a valid attribute" do
    Therapist.create!(@attr)
  end

  it "should require an email address" do
    no_email_therapist = Therapist.new(@attr.merge(:email => ""))
    no_email_therapist.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[therapist@foo.com THE_THERAPIST@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_therapist = Therapist.new(@attr.merge(:email => address))
      valid_email_therapist.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[therapist@foo,com therapist_at_foo.org example.therapist@foo.]
    addresses.each do |address|
      invalid_email_therapist = Therapist.new(@attr.merge(:email => address))
      invalid_email_therapist.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    Therapist.create!(@attr)
    therapist_with_duplicate_email = Therapist.new(@attr)
    therapist_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    Therapist.create!(@attr.merge(:email => upcased_email))
    therapist_with_duplicate_email = Therapist.new(@attr)
    therapist_with_duplicate_email.should_not be_valid
  end

  describe "passwords" do

    before(:each) do
      @therapist = Therapist.new(@attr)
    end

    it "should have a password attribute" do
      @therapist.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @therapist.should respond_to(:password_confirmation)
    end
  end

  describe "password validations" do

    it "should require a password" do
      Therapist.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      Therapist.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      Therapist.new(hash).should_not be_valid
    end

  end

  describe "password encryption" do

    before(:each) do
      @therapist = Therapist.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @therapist.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @therapist.encrypted_password.should_not be_blank
    end

  end

end
