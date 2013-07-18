class EntriesController < ApplicationController
  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.where(published: true) #TODO use Entries.published
    # you should hide unapproved entries even if they have the published field set to true
    # @entries = Entry.published (.published calls the .approved class method, see app/model/entry.rb for a suggestion)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entries }
    end
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    @entry = Entry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @entry }
    end
  end

  # GET /entries/new
  # GET /entries/new.json
  def new
    @entry = Entry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @entry }
    end
  end

  # GET /entries/1/edit
  def edit
    @entry = Entry.find(params[:id])
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(params[:entry])
      @entry.user = current_user
      @entry.approved = false unless current_user # approved field is true by default (see app/models/entry.rb)

    respond_to do |format|
      if @entry.save
        format.html do
          if @entry.user
            redirection_path = user_url(current_user) # redirect to user#show if user is already signed in
            flash_message = 'Entry was successfully created.' # set the correct flash message
          else
            redirection_path = preview_entry_path(@entry.id) # redirect to entries/:id/preview when user is not signed in
            flash_message = 'Entry needs to be approved.' # set the correct flash message for this unapproved entry
          end
          redirect_to redirection_path, notice: flash_message # user the local variables set in the conditional statements above
        end
        format.json { render json: @entry, status: :created, location: @entry }
      else
        format.html { render action: "new" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def preview
    #TODO this is exactly like the show action, a refactoring could be done in app/views/entries/show.html.erb with conditional renderings and partials
    @entry = Entry.find(params[:id])
  end

  # PUT /entries/1
  # PUT /entries/1.json
  def update
    @entry = Entry.find(params[:id])
    @entry.user = current_user

    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        format.html { redirect_to user_url(current_user), notice: 'Entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to user_url(current_user), notice: 'Entry was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
