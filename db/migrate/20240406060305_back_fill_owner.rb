class BackFillOwner < ActiveRecord::Migration[7.1]
  def change
    candidates = Candidate.all
    candidates.each do |candidate|
      candidate.update(owner: candidate.user)
    end
  end
end
