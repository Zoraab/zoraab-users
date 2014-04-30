class EntriesController < ApplicationController
  def index
  end
  
  def new
    p '*'*100
    p 'hello!!'
    p params
    respond_to do |format|
      msg = { :status => "ok", :message => "Success!" }
      format.json  { render :json => msg }
    end
  end
end