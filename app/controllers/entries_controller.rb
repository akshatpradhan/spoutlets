class EntriesController < ApplicationController
  # GET /entries
  # GET /entries.json
  def index

    # NOTE: You were using Entry.all.where. This is wrong. It'll fetch all the entries and then will query on those records. Will bring your
    #system down if you have thoudands or millions of entires. Directly use where clause. One way to ascertain your queries is to look
    #at the development.log or test.log to see what queries are being fired. There is one more way to see corresponding queries for commands
    #fired in rails console. Very helpful. Remind me to give that to you. Makes it super easy to write correct lookups if you understand 
    #mongodb queries well.
    @entries = Entry.where(published: true)

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

    respond_to do |format|
      if @entry.save
        # NOTE: Code was incorrect here, as it was redirecting to user. It should have been redirecting to entry
        format.html { redirect_to entry_url(@entry), notice: 'Entry was successfully created.' }
        format.json { render json: @entry, status: :created, location: @entry }
      else
        format.html { render action: "new" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /entries/1
  # PUT /entries/1.json
  def update
    # NOTE: VERY IMPORTANT: Although it may not be relevant here, but in updates you should always ensure that id that is being passed in
    # is indeed for an entry created by current user. Lot of systems leave this loophole behind allowing users to guess ids
    # and update entities when they shouldn't be allowed to. Modifying a comment by another user on a site is a simple example
    # of that. In such cases, updates should be done in following way:
    # 
    # current_user.entries.find(params[:id])
    #
    # The above statement automagically scopes the entires by user id (who is the owner)
    @entry = Entry.find(params[:id])
    @entry.user = current_user

    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        format.html { redirect_to entry_url(@entry), notice: 'Entry was successfully updated.' }
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
    #@entry = Entry.find(params[:id])
    #@entry.destroy

    respond_to do |format|
      if @entry = current_user.entries.where(:_id => params[:id]).first
        @entry.destroy
        #NOTE: while url in route name is great like entries_url. It is usually a good practice to use path. Like entries_path. Lot of applications do
        #production configurations on host name etc. urls have a chance to break them often. path is relative and not exact url; so it appends respective
        #hostname silently
        format.html { redirect_to entries_path, notice: 'Entry was successfully deleted.' }
        format.json { head :no_content }
      else
        format.html { redirect_to entries_path, notice: 'Entry not found in system' }
        format.json { render json: "", status: :unprocessable_entity }
      end
    end
  end
end
