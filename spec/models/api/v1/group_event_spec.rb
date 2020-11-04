require 'rails_helper'

RSpec.describe GroupEvent, type: :model do
  subject {
    described_class.new(
                        name: "name",
                        user: User.create(name: "test",email: "test@gmail.com")
                      )
  }
  it "is not valid without a name" do 
    subject.name=nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a user" do 
    subject.user=nil
    expect(subject).to_not be_valid
  end
  it "is valid without a description" do 
    subject.description=nil
    expect(subject).to be_valid
  end
  it "is valid without a started_at" do 
    subject.started_at=nil
    expect(subject).to be_valid
  end
  it "is valid without a deleted_at" do 
    subject.deleted_at=nil
    expect(subject).to be_valid
  end
  it "is valid without a ended_at" do 
    subject.ended_at=nil
    expect(subject).to be_valid
  end
  it "is valid without a location" do 
    subject.location=nil
    expect(subject).to be_valid
  end
end