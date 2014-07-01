require 'spec_helper' 

describe "Group pages" do 

  subject { page } 

  describe "index" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:group, name: "queue stuffers 1", primary_investigator: "Donny Vascoe",  department: "physics",     office: " ", phone: " ")
      FactoryGirl.create(:group, name: "queue stuffers 2", primary_investigator: "Victor Vitto",  department: "astronomy",   office: " ", phone: " ")
      FactoryGirl.create(:group, name: "queue stuffers 3", primary_investigator: "Bridget Jones", department: "mathematics", office: " ", phone: " ")
      visit groups_path
    end

    it { should have_title('All Groups') }
    it { should have_content('All Groups') }

    it "should list each group" do
      Group.all.each do |group|
        expect(page).to have_selector('li', text: group.name)
      end
    end
  end

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

      describe "after submission" do
        before { click_button submit }

        it { should have_title('New Group') }
        it { should have_content('error') }
      end

    end

    describe "with valid information" do
      before do
        fill_in "Name",                 with: "Center for Bioinformatics"
        fill_in "Primary investigator", with: "Ilya Vakser"
        fill_in "Department",           with: "Bioinformatics"
        fill_in "Office",               with: "MULTIDISCIPLINARY RESEARCH BUILDING"
        fill_in "Phone",                with: "785-864-1057"
      end

      it "should create a group" do
        expect { click_button submit }.to change(Group, :count).by(1)
      end

      describe "after saving the group" do
        before { click_button submit }
        let(:group) { Group.find_by(name: 'Center for Bioinformatics'.downcase) }

        it { should have_title(group.name) }
        it { should have_selector('div.alert.alert-success', text: 'Congratulations') }
      end

    end

  end

  describe "edit group" do
    let(:group) { FactoryGirl.create(:group) }
    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      #sign_in user, no_capybara: true 
      visit edit_group_path(group)
    end

    describe "page" do
      it { should have_content("Update the Group") }
      it { should have_title("Edit Group") }
    end

    describe "with invalid information" do
      let(:bogo_name)                 { " " }
      let(:bogo_primary_investigator) { " " }
      let(:bogo_department)           { " " }
      let(:bogo_office)               { " " }
      let(:bogo_phone)                { " " }

      before do
        fill_in "Name",                 with: bogo_name
        fill_in "Primary investigator", with: bogo_primary_investigator
        fill_in "Department",           with: bogo_department
        fill_in "Office",               with: bogo_office
        fill_in "Phone",                with: bogo_phone

        click_button "Save changes"
      end

      it { should have_content('error') }
    end


    describe "with valid information" do

      let(:new_name)                 { "New Group Name" }
      let(:new_primary_investigator) { "Someone Else" }
      let(:new_department)           { "Other Department" }
      let(:new_office)               { "Somewhere Else" }
      let(:new_phone)                { "785-867-5309" }

      before do
        fill_in "Name",                 with: new_name
        fill_in "Primary investigator", with: new_primary_investigator
        fill_in "Department",           with: new_department
        fill_in "Office",               with: new_office
        fill_in "Phone",                with: new_phone
        click_button "Save changes"
      end

      it { should have_title(new_name.downcase) }
      it { should have_selector('div.alert.alert-success') }
      #it { should have_link('Sign out', href: signout_path) }
      specify { expect(group.reload.name).to                  eq new_name.downcase }
      specify { expect(group.reload.primary_investigator).to  eq new_primary_investigator }
      specify { expect(group.reload.department).to            eq new_department }
      specify { expect(group.reload.office).to                eq new_office }
      specify { expect(group.reload.phone).to                 eq new_phone }
    end

  end

end
