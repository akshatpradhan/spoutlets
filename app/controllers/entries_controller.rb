class EntriesController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :index]

  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.where(published: true)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entries }
    end
  end

  def like
    @entry = Entry.find(params[:id])
    respond_to do |format|
      format.html do
        if current_user
          @entry.like current_user
          redirect_to entries_url
        else
          redirect_to root_url, notice: "You need to sign in to like an entry."
        end
      end
      format.js
    end
  end

  def unlike
    @entry = Entry.find(params[:id])
    respond_to do | format |
      format.html do
        @entry.unlike current_user
        redirect_to entries_url
      end
      format.js
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
        format.html { redirect_to user_url(current_user), notice: 'Entry was successfully created.' }
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
