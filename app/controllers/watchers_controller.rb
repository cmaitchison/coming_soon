require 'csv'
class WatchersController < ApplicationController

  before_filter :authenticate, :only => [:index]
  
  def index
    headers["Content-Disposition"] =  "attachment;filename=emails.csv"
    headers["Content-Type"] = "text/csv"
    render_csv("watchers-#{Time.now.strftime("%Y%m%d")}")
  end

  def render_csv(filename = nil)
    filename ||= params[:action]
    filename += '.csv'
    if request.env['HTTP_USER_AGENT'] =~ /msie/i
      headers['Pragma'] = 'public'
      headers["Content-type"] = "text/plain" 
      headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
      headers['Content-Disposition'] = "attachment; filename=\"#{filename}\"" 
      headers['Expires'] = "0" 
    else
      headers["Content-Type"] ||= 'text/csv'
      headers["Content-Disposition"] = "attachment; filename=\"#{filename}\"" 
    end

    render :layout => false
  end

  def create
    @watcher = Watcher.new(:email =>params[:email])
    @watcher.ip = request.remote_ip
    respond_to do |format|
      if @watcher.save
        WatcherMailer.new_watcher(@watcher).deliver
        format.html { redirect_to root_url, notice: 'Watcher was successfully created.' }
        format.json { render json: @watcher, status: :created, location: @watcher }
      else
        format.html { redirect_to root_url }
        format.json { render json: @watcher.errors, status: :unprocessable_entity }
      end
    end
  end

end
