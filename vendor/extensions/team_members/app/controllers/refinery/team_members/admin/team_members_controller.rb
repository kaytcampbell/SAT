module Refinery
  module TeamMembers
    module Admin
      class TeamMembersController < ::Refinery::AdminController

        crudify :'refinery/team_members/team_member',
                :title_attribute => 'name'

        private

        # Only allow a trusted parameter "white list" through.
        def team_member_params
          params.require(:team_member).permit(:name, :position, :photo_id, :blurb)
        end
      end
    end
  end
end
