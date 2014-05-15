class EntriesController < ApplicationController
  skip_before_filter  :verify_authenticity_token, :only => [:new,:show]
  def index
    @entries = Entry.reorder("created_at DESC").page(params[:page]).per_page(50)
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
  
  def show
    @entry = Entry.find(params[:id])
    respond_to do |format|
        format.json  { render :json => @entry }
    end
  end
end