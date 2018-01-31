
FactoryGirl.define do
  factory :team_member, :class => Refinery::TeamMembers::TeamMember do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

