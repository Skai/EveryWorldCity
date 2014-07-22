class ContactsController < ApplicationController
  def new 
    @contact = Contact.new 
  end
  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    respond_to do |format|
      if @contact.deliver
        format.js { render json: {status: 'ok'}}
      else
        format.json{ head :error }
        format.js
      end
    end
  end
end
