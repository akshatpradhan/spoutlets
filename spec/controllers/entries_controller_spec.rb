require 'spec_helper'

describe EntriesController do

  def valid_attributes
    { "content" => "" }
  end

  def valid_session
    {}
  end

  before do
    # NOTE: I personally hate stubbing and mocking. However instead of repeating the user id in session for each 
    # request it seems better that we stub the user at controller level. Application should have it's respective
    # tests to ensure that current user functionality works fine. I would recommend using devise for authentication
    # as it is far mature, has better support for omniauth and also provides test helpers to take the sign_in_user
    # pain away. I haven't used cancan in a while; for all I know you may have similar helpers here too. If thats so
    # use them. Far better than mocking.
    @user = FactoryGirl.create(:logged_in_user)
    controller.stub!(:current_user).and_return(@user)
  end

  describe "GET index" do

    # NOTE: Use factories. You were manually creating entry. Which is also ok; but it failed the mongoid validation
    # since it did not have category, which is mandatory
    # Also you look for all the entries where published is true, however in your object you werent doing that
    let(:entry) { FactoryGirl.create(:published_entry) }

    it "assigns all published entires" do
      # NOTE: Why do you need empty hash and valid session? Removed it since, it isn't used as yet
      get :index
      assigns(:entries).should eq([entry])
    end
  end

  describe "GET show" do

    let(:entry) { FactoryGirl.create(:published_entry) }

    it "assigns the requested entry" do
      get :show, {:id => entry.to_param}
      assigns(:entry).should eq(entry)
    end
  end

  describe "GET new" do
    it "assigns a new entry as @entry" do
      get :new
      assigns(:entry).should be_a_new(Entry)
    end
  end

  describe "GET edit" do

    let(:entry) { FactoryGirl.create(:published_entry) }

    it "assigns the requested entry as @entry" do
      get :edit, {:id => entry.to_param}
      assigns(:entry).should eq(entry)
    end
  end

  describe "POST create" do

    let(:entry_attributes) { FactoryGirl.attributes_for(:published_entry) }

    describe "with valid params" do
      it "creates a new Entry" do
        expect {
          post :create, {:entry => entry_attributes}
        }.to change(Entry, :count).by(1)
      end

      it "assigns a newly created entry as @entry" do
        post :create, {:entry => entry_attributes}

        assigns(:entry).should be_a(Entry)
        assigns(:entry).should be_persisted
      end

      it "redirects to the created entry" do
        post :create, {:entry => entry_attributes }

        # NOTE I tend to leave a blank like between the assertions and setup in a spec, it makes it easy for anyone
        # to spot what the assertions are and what the setup is. Only a sugar coating thing. Feel free to style them 
        # with what works for you.
        response.should redirect_to(Entry.last)
      end
    end

    describe "with invalid params" do

      let(:invalid_entry_attributes) { FactoryGirl.attributes_for(:invalid_entry) }

      it "assigns a newly created but unsaved entry as @entry" do
        # Trigger the behavior that occurs when invalid params are submitted
        # NOTE: Avoid mocking and instead try to save an invalid entry. Much cleaner. Tomorrow
        # if your entry object changes (lets say validation has changed), mocks and stubs hide the changes, as you don't really rely 
        # on real objects but instead you rely on mocks which will never be wrong. So test will pass
        # and it'll present a confusing picture to anyone. Once validations on enties change now, this test will fail too 
        # and you'll have to fix it here also. A minor overhead for more clarity in code.
        post :create, {:entry => invalid_entry_attributes }
        assigns(:entry).should be_a_new(Entry)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        post :create, {:entry => invalid_entry_attributes }
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do

      let(:entry) { FactoryGirl.create(:published_entry) }
      let(:entry_attributes) { entry.attributes }

      it "updates the requested entry" do
        # Assuming there are no other entries in the database, this
        # specifies that the Entry created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        put :update, {:id => entry.to_param, :entry => entry_attributes}
      end

      it "assigns the requested entry as @entry" do
        put :update, {:id => entry.to_param, :entry => entry_attributes}

        assigns(:entry).should eq(entry)
      end

      it "redirects to the entry" do
        put :update, {:id => entry.to_param, :entry => entry_attributes}

        response.should redirect_to(entry)
      end
    end

    describe "with invalid params" do

      let(:entry) { FactoryGirl.create(:published_entry) }
      let(:invalid_entry_attributes) { entry.content = nil; entry.attributes }

      it "assigns the entry as @entry" do
        put :update, {:id => entry.to_param, :entry => invalid_entry_attributes}

        assigns(:entry).should eq(entry)
      end

      it "re-renders the 'edit' template" do
        put :update, {:id => entry.to_param, :entry => invalid_entry_attributes}

        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do

    # NOTE: Factories simplifies object creation if used well and also reduce the boilerplate code in your specs.
    # Since specs themselves are not tested; lesser code or more standard way of doing something is better than hand created
    # objects.
    before do
      @entry = FactoryGirl.create(:published_entry, :user => @user)
      @entry_of_another_user = FactoryGirl.create(:published_entry, :user => FactoryGirl.create(:end_user))
      # NOTE: I have used a before do construct here instead of let because, let does an entry creation only when called. In this case
      # it is called inside the expect block. So that means that when expectation is set count for created entries is still 0. So the test
      # will fail with that construct.
    end

    it "destroys the requested entry" do
      expect {
        delete :destroy, {:id => @entry.to_param}
      }.to change{Entry.where(:id => @entry.id).count}.from(1).to(0)
      # NOTE: from and to syntax for expecting change seems more clear to me, so making that subtle change
    end

    it "redirects to the entries list" do
      delete :destroy, {:id => @entry.to_param}

      response.should redirect_to(entries_url)
    end

    it "should be allowed if entry belongs to current user" do
      delete :destroy, {:id => @entry_of_another_user.to_param}
      
      response.should redirect_to(entries_url)
      flash[:notice].should eq "Entry not found in system"
      # NOTE: You can test the flash messages by doing this simple assertion in your controller.
    end
  end

end
