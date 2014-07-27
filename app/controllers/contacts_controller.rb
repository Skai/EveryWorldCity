class ContactsController < ApplicationController
  def new 
    @contact = Contact.new
    render :layout => false
  end
  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    respond_to do |format|
      if @contact.deliver
        format.json { render json: { status: 'ok', success: true }}
      else
        format.json { render json: { status: 'error', success: false }}
      end
    end
  end
end
