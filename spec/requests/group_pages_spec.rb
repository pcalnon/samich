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

end
