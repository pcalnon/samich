require 'spec_helper'

describe Group do

  before do
    @group = Group.new(name: "foo", primary_investigator: "Foo Bar Bas", department: "EECS", office: "240 Nichols Hall", phone: "785-864-7715") 
  end

  subject { @group }

  it { should respond_to(:name) }
  it { should respond_to(:primary_investigator) }
  it { should respond_to(:department) }
  it { should respond_to(:office) }
  it { should respond_to(:phone) }

  it { should be_valid }

  describe "when name is not present" do
    before { @group.name = " " }
    it { should_not be_valid }
  end

  describe "when name is already taken" do
    before do
      group_with_same_name = @group.dup
      group_with_same_name.name = @group.name.upcase
      group_with_same_name.save
    end

    it { should_not be_valid }
  end


  describe "when primary_investigator is not present" do
    before { @group.primary_investigator = " " }
    it { should_not be_valid }
  end

#  describe "when department is not present" do
#    before { @group.department = " " }
#    it { should_not be_valid }
#  end
#
#  describe "when office is not present" do
#    before { @group.office = " " }
#    it { should_not be_valid }
#  end
#
#  describe "when phone is not present" do
#    before { @group.phone = " " }
#    it { should_not be_valid }
#  end

end
