class SpecialcontestsController < ApplicationController
  #before_action :set_contest, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :except=>[:index]

  def index
  	@specialcontests = Contest.by_status('Active').where("end_date >= ?", Time.zone.now).where("contest_type = ?","Special")  	
  	@specialentries = Entry.by_status('Approved').limit(16)
  end
end
