# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "TeamMembers" do
    describe "Admin" do
      describe "team_members", type: :feature do
        refinery_login

        describe "team_members list" do
          before do
            FactoryGirl.create(:team_member, :name => "UniqueTitleOne")
            FactoryGirl.create(:team_member, :name => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.team_members_admin_team_members_path
            expect(page).to have_content("UniqueTitleOne")
            expect(page).to have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.team_members_admin_team_members_path

            click_link "Add New Team Member"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Name", :with => "This is a test of the first string field"
              expect { click_button "Save" }.to change(Refinery::TeamMembers::TeamMember, :count).from(0).to(1)

              expect(page).to have_content("'This is a test of the first string field' was successfully added.")
            end
          end

          context "invalid data" do
            it "should fail" do
              expect { click_button "Save" }.not_to change(Refinery::TeamMembers::TeamMember, :count)

              expect(page).to have_content("Name can't be blank")
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:team_member, :name => "UniqueTitle") }

            it "should fail" do
              visit refinery.team_members_admin_team_members_path

              click_link "Add New Team Member"

              fill_in "Name", :with => "UniqueTitle"
              expect { click_button "Save" }.not_to change(Refinery::TeamMembers::TeamMember, :count)

              expect(page).to have_content("There were problems")
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:team_member, :name => "A name") }

          it "should succeed" do
            visit refinery.team_members_admin_team_members_path

            within ".actions" do
              click_link "Edit this team member"
            end

            fill_in "Name", :with => "A different name"
            click_button "Save"

            expect(page).to have_content("'A different name' was successfully updated.")
            expect(page).not_to have_content("A name")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:team_member, :name => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.team_members_admin_team_members_path

            click_link "Remove this team member forever"

            expect(page).to have_content("'UniqueTitleOne' was successfully removed.")
            expect(Refinery::TeamMembers::TeamMember.count).to eq(0)
          end
        end

      end
    end
  end
end
