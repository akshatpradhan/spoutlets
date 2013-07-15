class TherapistsController < ApplicationController
  # GET /therapists
  # GET /therapists.json
  def index
    @therapists = Therapist.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @therapists }
    end
  end

  # GET /therapists/1
  # GET /therapists/1.json
  def show
    @therapist = Therapist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @therapist }
    end
  end

  # GET /therapists/new
  # GET /therapists/new.json
  def new
    @therapist = Therapist.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @therapist }
    end
  end

  # GET /therapists/1/edit
  def edit
    @therapist = Therapist.find(params[:id])
  end

  # POST /therapists
  # POST /therapists.json
  def create
    @therapist = Therapist.new(params[:therapist])

    respond_to do |format|
      if @therapist.save
        format.html { redirect_to @therapist, notice: 'Therapist was successfully created.' }
        format.json { render json: @therapist, status: :created, location: @therapist }
      else
        format.html { render action: "new" }
        format.json { render json: @therapist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /therapists/1
  # PUT /therapists/1.json
  def update
    @therapist = Therapist.find(params[:id])

    respond_to do |format|
      if @therapist.update_attributes(params[:therapist])
        format.html { redirect_to @therapist, notice: 'Therapist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @therapist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /therapists/1
  # DELETE /therapists/1.json
  def destroy
    @therapist = Therapist.find(params[:id])
    @therapist.destroy

    respond_to do |format|
      format.html { redirect_to therapists_url }
      format.json { head :no_content }
    end
  end
end
