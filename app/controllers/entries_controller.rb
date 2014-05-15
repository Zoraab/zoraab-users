class EntriesController < ApplicationController
  skip_before_filter  :verify_authenticity_token, :only => :new
  def index
    @entries = Entry.all
  end
  
  def new
    p '*'*100
    p params
    @entry = Entry.new_submission(params)
    if @entry.save
      respond_to do |format|
        msg = { :status => "ok", :message => "Success!", :url => @entry.signup_url }
        format.json  { render :json => msg }
      end
    end
  end
end