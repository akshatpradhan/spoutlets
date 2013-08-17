require 'spec_helper'

describe EntriesController do

  let(:entry) { FactoryGirl.build(:entry) }
  let(:valid_attributes) { entry.attributes }
  let(:user) { FactoryGirl.create(:user)}

  before do
    session[:user_id] = user.id
  end

  describe "GET index" do
    it "returns the entries list" do
      entry.save!
      get :index
      assigns(:entries).should eq([entry])
    end
  end

  describe "GET index for non-logged in user" do
    it "redirect to the root path" do
      session[:user_id] = nil
      get :index
      response.should redirect_to(root_path)
    end
  end

  describe "GET new" do
    it "assigns a new entry as @entry" do
      get :new, {}
      assigns(:entry).should be_a_new(Entry)
    end
  end

  describe "GET new for non-logged in user" do
    it "redirect to the root path" do
      session[:user_id] = nil
      get :new
      response.should redirect_to(root_path)
    end
  end

  describe "GET edit" do
    it "assigns the requested entry as @entry" do
      entry.save!
      get :edit, {id: entry.to_param}
      assigns(:entry).should eq(entry)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Entry" do
        expect {
          post :create, {entry: valid_attributes}
        }.to change(Entry, :count).by(1)
      end

      it "assigns a newly created entry as @entry" do
        post :create, {entry: valid_attributes}
        assigns(:entry).should be_a(Entry)
        assigns(:entry).should be_persisted
      end

      it "redirects to the created entry" do
        post :create, {entry: valid_attributes}
        response.should redirect_to(user_url(user))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved entry as @entry" do
        # Trigger the behavior that occurs when invalid params are submitted
        Entry.any_instance.stub(:save).and_return(false)
        post :create, {entry: { "content" => "invalid value" }}
        assigns(:entry).should be_a_new(Entry)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Entry.any_instance.stub(:save).and_return(false)
        post :create, {entry: { "content" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    before do
      entry.save!
    end

    describe "with valid params" do
      it "updates the requested entry" do

        # Assuming there are no other entries in the database, this
        # specifies that the Entry created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Entry.any_instance.should_receive(:update_attributes).with({ "content" => "" })
        put :update, {id: entry.to_param, entry: { "content" => "" }}
      end

      it "assigns the requested entry as @entry" do
        user = FactoryGirl.create(:user)
        session[:session_id] = user.id
        put :update, {id: entry.to_param, entry: valid_attributes}
        assigns(:entry).should eq(entry)
      end

      it "redirects to the user profile path" do
        put :update, {id: entry.to_param, entry: valid_attributes}
        response.should redirect_to(user_url(user))
      end
    end

    describe "with invalid params" do
      it "assigns the entry as @entry" do
        # Trigger the behavior that occurs when invalid params are submitted
        Entry.any_instance.stub(:save).and_return(false)
        put :update, {id: entry.to_param, entry: { "content" => "invalid value" }}
        assigns(:entry).should eq(entry)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Entry.any_instance.stub(:save).and_return(false)
        put :update, {id: entry.to_param, entry: { "content" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before do
      entry.save!
    end
    it "destroys the requested entry" do
      expect {
        delete :destroy, {id: entry.to_param}
      }.to change(Entry, :count).by(-1)
    end

    it "redirects to the user profile path" do
      delete :destroy, {id: entry.to_param}
      response.should redirect_to(user_url(user))
    end
  end

end
