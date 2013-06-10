require 'spec_helper'

describe Entry do
  it { should respond_to :user }
  it { should validate_presence_of :content }
  it { should validate_presence_of :category }
end
