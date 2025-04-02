class CreateJoinTableCandidatesCampaigns < ActiveRecord::Migration[8.0]
  def change
    create_join_table :candidates, :campaigns do |t|
    end
  end
end
