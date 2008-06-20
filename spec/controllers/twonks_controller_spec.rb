require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TwonksController do
  fixtures :votes, :users, :twonks
  before do
    @twonk = mock("twonk")
    @twonks = [@twonk]
    @user = mock("user")
    @users = [@user]
    @vote = mock("vote")
    @votes = [@vote]
  end
  
  describe TwonksController, "non-logged in users" do

    #Delete this example and add some real ones
    it "can see the index page" do
      Twonk.should_receive(:find).with(:all, :order => "votes_count DESC", :limit => 20).and_return(@twonks)
      Twonk.should_receive(:find).with(:all, :order => "id DESC", :limit => 20).and_return(@twonks)
      get 'index'
    end
  
    it "can't begin to create a new twonk" do
      get 'new', { }, { :user => 1 }
      access_denied_message
    end
  
    it "can't create a new twonk" do
      post 'create', :twonk => { :name => "You", :location => "Somewhere" }
      access_denied_message
    end
    
    it "can't edit a twonk" do
      get 'edit', :id => 1
      access_denied_message
    end
  
    it "can't update a twonk" do
      post 'update', { :id => 1, :twonk => { :name => "You", :location => "Somewhere Else" } }
      access_denied_message
    end
  
    it "can't destroy a twonk" do
      get 'destroy', { :id => 1 }
      access_denied_message
    end
  end
  
  describe TwonksController, "logged-in users" do
    fixtures :users, :twonks, :votes
    
    before do
      login_as :plebian
    end
    
    it "can see the index page" do
      Twonk.should_receive(:find).with(:all, :order => "votes_count DESC", :limit => 20).and_return(@twonks)
      Twonk.should_receive(:find).with(:all, :order => "id DESC", :limit => 20).and_return(@twonks)
      get 'index'
    end
    
    it "can begin to create a new twonk" do
      Twonk.should_receive(:new).and_return(@twonk)
      @twonk.should_receive(:votes).and_return(@votes)
      @votes.should_receive(:build).and_return(@vote)
      get 'new'
    end
    
    it "can create a new twonk" do
      User.should_receive(:find).and_return(@user)
      @user.should_receive(:nominations).and_return(@twonks)
      @twonks.should_receive(:new).and_return(@twonk)
      @twonk.should_receive(:save).and_return(true)
      post 'create', :twonk => { :name => "You", :location => "Somewhere" }
      flash[:success].should_not be_nil
      response.should redirect_to(twonk_path(@twonk))
    end
    
    it "cannot create an invalid twonk" do
      User.should_receive(:find).and_return(@user)
      @user.should_receive(:nominations).and_return(@twonks)
      @twonks.should_receive(:new).and_return(@twonk)
      @twonk.should_receive(:save).and_return(false)
      post 'create', :twonk => { }
      response.should render_template("new")
    end
    
    it "can edit their own twonks" do
      Twonk.should_receive(:find).and_return(@twonk)
      @twonk.should_receive(:nominated_by).and_return(users(:plebian))
      get 'edit', :id => 1
      response.should redirect_to(twonks_path)
    end
    
    it "cannot edit any other person's twonks" do
      Twonk.should_receive(:find).and_return(@twonk)  
      @twonk.should_receive(:nominated_by).and_return(users(:other_plebian))
      get 'edit', :id => 1, :user => 1
      puts session.inspect
      response.should redirect_to(twonks_path)
    end
  
  end
end
