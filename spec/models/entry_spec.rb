require 'spec_helper'

describe Entry do

  context "attributes" do

    it { should respond_to :title            }
    it { should respond_to :content          }
    it { should respond_to :happiness_level  }
    it { should respond_to :anxiety_level    }
    it { should respond_to :irritation_level }
    it { should respond_to :category         }
    it { should respond_to :published        }

  end

  context "anxious entry" do
    
    let(:entry) { FactoryGirl.build(:anxious_entry) }

    it "should have anxiety level set as panic" do
      entry.anxiety_level.should eq "panic"
    end

  end
  
  context "happy entry" do

    before do
      @entry = FactoryGirl.build(:happy_entry)
    end

    it "should have level set to happy" do
      @entry.anxiety_level.should eq "happy"
    end

  end

end
