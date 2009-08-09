require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a submission exists" do
  Submission.all.destroy!
  request(resource(:submissions), :method => "POST", 
    :params => { :submission => { :id => nil }})
end

describe "resource(:submissions)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:submissions))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of submissions" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a submission exists" do
    before(:each) do
      @response = request(resource(:submissions))
    end
    
    it "has a list of submissions" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Submission.all.destroy!
      @response = request(resource(:submissions), :method => "POST", 
        :params => { :submission => { :id => nil }})
    end
    
    it "redirects to resource(:submissions)" do
      @response.should redirect_to(resource(Submission.first), :message => {:notice => "submission was successfully created"})
    end
    
  end
end

describe "resource(@submission)" do 
  describe "a successful DELETE", :given => "a submission exists" do
     before(:each) do
       @response = request(resource(Submission.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:submissions))
     end

   end
end

describe "resource(:submissions, :new)" do
  before(:each) do
    @response = request(resource(:submissions, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@submission, :edit)", :given => "a submission exists" do
  before(:each) do
    @response = request(resource(Submission.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@submission)", :given => "a submission exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Submission.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @submission = Submission.first
      @response = request(resource(@submission), :method => "PUT", 
        :params => { :submission => {:id => @submission.id} })
    end
  
    it "redirect to the submission show action" do
      @response.should redirect_to(resource(@submission))
    end
  end
  
end

