require 'spec_helper'

describe EntriesController do

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # EntriesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  # before do
  #   @user = FactoryGirl.create(:user)
  # end

  describe "GET index" do
    let(:entry) { FactoryGirl.create(:entry) }
    it "returns the entries list" do
      get :index
      assigns(:entries).should eq([entry])
    end
  end

  describe "GET new" do
    it "assigns a new entry as @entry" do
      get :new, {}, valid_session
      assigns(:entry).should be_a_new(Entry)
    end
  end

  describe "GET edit" do
    let(:entry) { FactoryGirl.create(:entry) }
    it "assigns the requested entry as @entry" do
      get :edit, {:id => entry.to_param}, valid_session
      assigns(:entry).should eq(entry)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Entry" do
        expect {
          post :create, {:entry => valid_attributes}, valid_session
        }.to change(Entry, :count).by(1)
      end

      it "assigns a newly created entry as @entry" do
        post :create, {:entry => valid_attributes}, valid_session
        assigns(:entry).should be_a(Entry)
        assigns(:entry).should be_persisted
      end

      it "redirects to the created entry" do
        post :create, {:entry => valid_attributes}, valid_session
        response.should redirect_to(Entry.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved entry as @entry" do
        # Trigger the behavior that occurs when invalid params are submitted
        Entry.any_instance.stub(:save).and_return(false)
        post :create, {:entry => { "content" => "invalid value" }}, valid_session
        assigns(:entry).should be_a_new(Entry)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Entry.any_instance.stub(:save).and_return(false)
        post :create, {:entry => { "content" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:entry) { FactoryGirl.create(:entry) }
      let(:valid_attributes) { entry.attributes }
      it "updates the requested entry" do

        # Assuming there are no other entries in the database, this
        # specifies that the Entry created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Entry.any_instance.should_receive(:update_attributes).with({ "content" => "" })
        put :update, {:id => entry.to_param, :entry => { "content" => "" }}, valid_session
      end

      it "assigns the requested entry as @entry" do
        user = FactoryGirl.create(:user)
        session[:session_id] = user.id
        put :update, {:id => entry.to_param, :entry => valid_attributes}, valid_session
        assigns(:entry).should eq(entry)
      end

      it "redirects to the entry" do
        put :update, {:id => entry.to_param, :entry => valid_attributes}, valid_session
        response.should redirect_to(entry)
      end
    end

    describe "with invalid params" do
      it "assigns the entry as @entry" do
        entry = Entry.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Entry.any_instance.stub(:save).and_return(false)
        put :update, {:id => entry.to_param, :entry => { "content" => "invalid value" }}, valid_session
        assigns(:entry).should eq(entry)
      end

      it "re-renders the 'edit' template" do
        entry = Entry.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Entry.any_instance.stub(:save).and_return(false)
        put :update, {:id => entry.to_param, :entry => { "content" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested entry" do
      entry = Entry.create! valid_attributes
      expect {
        delete :destroy, {:id => entry.to_param}, valid_session
      }.to change(Entry, :count).by(-1)
    end

    it "redirects to the entries list" do
      entry = Entry.create! valid_attributes
      delete :destroy, {:id => entry.to_param}, valid_session
      response.should redirect_to(entries_url)
    end
  end

end
