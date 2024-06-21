class RecycleCandidates < Patterns::Service
  def call
    User.recruiters.each do |recruiter|
      recycle_candidates_for(recruiter)
    end
  end

  private

  def recycle_candidates_for(recruiter)
    openings = recruiter.openings
    openings.each do |opening|
      count = count_of_new_profiles_needed_for(recruiter, opening)
      recycle_candidates_for_opening(recruiter, opening, count) if count > 0
    end
  end

  def find_candidates_for_opening(recruiter, opening, count)
    profiles_fetched = 0
    candidates_fetched = []

    candidates = recycle_champions_for(recruiter, opening, count)
    profiles_fetched += candidates.count
    candidates_fetched += candidates
    puts "Found " + candidates.count.to_s + " champions for " + recruiter.name + " for " + opening.title

    return unless profiles_fetched < count

    candidates = recycle_icebox_for(recruiter, opening, count - profiles_fetched)
    profiles_fetched += candidates.count
    candidates_fetched += candidates
    puts "Found " + candidates.count.to_s + " icebox for " + recruiter.name + " for " + opening.title

    return unless profiles_fetched < count

    candidates = recycle_recent_for(recruiter, opening, count - profiles_fetched)
    profiles_fetched += candidates.count
    candidates_fetched += candidates
    puts "Found " + candidates.count.to_s + " recent for " + recruiter.name + " for " + opening.title

    return unless profiles_fetched < count

    candidates = recycle_incomplete_for(recruiter, opening, count - profiles_fetched)
    profiles_fetched += candidates.count
    candidates_fetched += candidates
    puts "Found " + candidates.count.to_s + " incomplete for " + recruiter.name + " for " + opening.title

    candidates = recycle_to_be_decided_incomplete_for(recruiter, opening, count - profiles_fetched)
    profiles_fetched += candidates.count
    candidates_fetched += candidates
    puts "Found " + candidates.count.to_s + " to be decided incomplete for " + recruiter.name + " for " + opening.title

    puts "Found " + profiles_fetched.to_s + " profiles for " + recruiter.name + " for " + opening.title + " out of " + count.to_s + " needed."
    return candidates_fetched
  end

  def recycle_candidates_for_opening(recruiter, opening, count)
    candidates = find_candidates_for_opening(recruiter, opening, count)
    candidates.each do |candidate|
      candidate.update(owner: recruiter)
      Recycle.create(candidate: candidate)
      add_event_for(candidate)
    end
  end

  def add_event_for(candidate)
    Event.new(eventable: candidate, action: "recycle", action_for_context: candidate.bucket, trackable: candidate, user: User.bot).save
  end

  def count_of_new_profiles_needed_for(recruiter, opening)
    total_quota_per_recruiter = 80 # 64 profiles per recruiter
    quota_per_opening = total_quota_per_recruiter / recruiter.openings.count
    existing_profiles = Recycle.includes(candidate: [:user, :role, :opening, :owner]).where(candidate: { owner_id: recruiter.id, role_id: opening.role_id }).count
    count = quota_per_opening - existing_profiles
    count = count.positive? ? count : 0
    return count
  end

  def recycle_champions_for(recruiter, opening, count)
    Candidate.where(bucket: "champions", role_id: opening.role_id).where("bucket_updated_on < ? ", 6.months.ago).limit(count)
  end

  def recycle_icebox_for(recruiter, opening, count)
    Candidate.where(bucket: "icebox", role_id: opening.role_id).where("bucket_updated_on < ? ", 6.months.ago).limit(count)
  end

  def recycle_recent_for(recruiter, opening, count)
    Candidate.where(bucket: "recent", role_id: opening.role_id).order(created_at: :desc).limit(count)
  end

  def recycle_incomplete_for(recruiter, opening, count)
    Candidate.where(bucket: "incomplete", role_id: opening.role_id).order(created_at: :desc).limit(count)
  end

  def recycle_to_be_decided_incomplete_for(recruiter, opening, count)
    Candidate.where(bucket: "incomplete", role_id: Role.find_by_title("To Be Decided").id).order(created_at: :desc).limit(count)
  end
end
