class Account::SourcesController < ApplicationController
  def index
    @sources = Source.all
    @source = Source.new
  end
end
