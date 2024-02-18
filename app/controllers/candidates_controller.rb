class CandidatesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @candidate = Candidate.new
    @roles = Role.all
    @openings = Opening.all
    @sources = Source.all
  end

  def recent
  end

  def hot
  end

  def pipeline
  end

  def champions
  end

  def joinings
  end

  def icebox
  end

  def archive
  end

  def incomplete
  end
end
