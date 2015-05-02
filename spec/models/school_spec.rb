require 'rails_helper'

RSpec.describe School, type: :model do
  it "should be valid" do
    expect(School.new(name: "school1")).to be_valid
  end
  
  it "should require name" do
    expect(School.new()).to_not be_valid
  end
  
  it "should not allow super long names" do
    long_name = "a" * 266
	expect(School.new(name: long_name)).to_not be_valid
  end
  
  it "should not allow duplicate names" do
    s = School.create!(name: "dup")
	expect(School.new(name: "dup")).to_not be_valid
	s.destroy
  end
end
