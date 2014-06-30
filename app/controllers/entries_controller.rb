class EntriesController < ApplicationController

  def create
    @entry = Entry.new(entry_params)
    @entry.author = @current_user.name + ' ' + @current_user.surname
    @entry.employee = false
    respond_to do |format|
      if @entry.save
        format.html { redirect_to support_url, notice: 'Entry was created succesfully' }
        #format.json { render action: 'show', status: :created, location: @inquiry }
      else
        format.html { redirect_to support_url, error: 'Entry could not be created.' }
        #format.json { render json: @inquiry.errors, status: :unprocessable_entity }
        logger.warn "Entry could not be created: #{@entry.attributes.inspect}, is valid?: #{@entry.valid?}"
      end
    end
  end



private

# Never trust parameters from the scary internet, only allow the white list through.
def entry_params
  params.require(:entry).permit(:message, :inquiry_id)
end


end
