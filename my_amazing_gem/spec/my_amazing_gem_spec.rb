require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "MyAmazingGem" do

  before do
    @the_followed = User.create!(:first_name => "Dan", :last_name => "Garland")
    @the_follower = User.create!(:first_name => "Sally", :last_name => "Smith")
  end

  it "should make a string lively" do
    "boring".lively.should_not eq("boring")  
  end

  def app
    MyAmazingService
  end

  describe "My Amazing Service" do

    it "says hello" do
      get '/'
      last_response.should be_ok
      last_response.body.should_not eq("Hello")
    end
  end

  describe "POST to /users/:id/follows/:follower_id" do
    before do
      post "/users/#{@the_followed.id}/follows/#{@the_follower.id}"
    end

    it "should return 200" do
      last_response.should be_ok
    end

    it "should setup he follow relationships" do
      @the_followed.reload.users_following.should include(@the_follower)
      @the_follower.reload.users_followed.should include(@the_followed)
    end
   
    describe "GET to index" do
      before do 
        Follow.create!(:users_followed_id => @the_followed, :users_following_id => @the_follower)
        get "/users/#{@the_followed.id}/follows"
      end
    
      it "should return valid JSON" do
        last_response.should be_ok
        last_response.content_type.should eq('application/json;charset=utf-8')
        lambda { JSON(last_response.body) }.should_not raise_exception
      end
    end
  end
end
