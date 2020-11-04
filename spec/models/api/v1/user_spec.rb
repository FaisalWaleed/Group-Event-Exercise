require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    described_class.new(email: "email@email.com",
                        name: "name"
                      )
  }
 it "is not valid without a email" do 
  subject.email=nil
  expect(subject).to_not be_valid  
  end
 it "is not valid without a name" do 
  subject.name=nil
  expect(subject).to_not be_valid
  end
end