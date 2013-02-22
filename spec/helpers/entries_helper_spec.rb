require 'spec_helper'

describe EntriesHelper do
  context "today" do
    def nicely_formatted(object)
      object.to_formatted_s(:date_nice)
    end

    it "must give today's date" do
      helper.today.should == nicely_formatted(Date.today)
    end

    context "nicely formatted" do
      specify "DateTime must have the proper format, including single digit" do
        nicely_formatted(DateTime.new(2000,10,5)).should == "Thu Oct 5, 2000"
      end

      specify     "Date must have the proper format, including single digit" do
        nicely_formatted(    Date.new(2000,10,5)).should == "Thu Oct 5, 2000"
      end

      specify     "Time must have the proper format, including single digit" do
        nicely_formatted(    Time.new(2000,10,5)).should == "Thu Oct 5, 2000"
      end
    end
  end
end
