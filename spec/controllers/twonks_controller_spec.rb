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
  
  describe TwonksController, "non-logged in user" do

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
  
  describe TwonksController, "logged in user" do
    before do
      login_as("plebian")
    end
    
    it "can begin to create a new twonk" do
      Twonk.should_receive(:new).and_return(@twonk)
      @twonk.should_receive(:votes).and_return(@votes)
      @votes.should_receive(:build).and_return(@vote)
      get 'new'
    end
      
      
  end
end 