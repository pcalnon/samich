require 'spec_helper'

describe "Group pages" do

  subject { page }

  describe "group profile page" do
    let(:group) { FactoryGirl.create(:group) }
    before { visit group_path(group) }

    it { should have_content(group.name) }
    it { should have_content(group.primary_investigator) }
    it { should have_content(group.department) }
    it { should have_content(group.office) }
    it { should have_content(group.phone) }
  end

  describe "new group" do

    before { visit new_group_path }

    let(:submit) { "New Group" }

    describe "with invalid information" do
      it "should not create a group" do
        expect { click_button submit }.not_to change(Group, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",                 with: "Bioinformatics"
        fill_in "Primary investigator", with: "1"
        fill_in "Department",           with: "1"
        fill_in "Office",               with: "1"
        fill_in "Phone",                with: "1"
      end

      it "should create a group" do
        expect { click_button submit }.to change(Group, :count).by(1)
      end

    end

  end

end
