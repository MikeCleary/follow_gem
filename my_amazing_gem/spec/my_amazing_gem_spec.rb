require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "MyAmazingGem" do
  it "should make a string lively" do
    "boring".lively.should_not eq("boring")  
  end

  describe "My Amazing Service" do
    def app
      MyAmazingService
    end

    it "says hello" do
      get '/'
      last_response.should be_ok
      last_response.body.should_not eq("Hello")
    end
  end

end
