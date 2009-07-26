require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a invite exists" do
  Invite.all.destroy!
  request(resource(:invites), :method => "POST", 
    :params => { :invite => { :id => nil }})
end

describe "resource(:invites)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:invites))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of invites" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a invite exists" do
    before(:each) do
      @response = request(resource(:invites))
    end
    
    it "has a list of invites" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Invite.all.destroy!
      @response = request(resource(:invites), :method => "POST", 
        :params => { :invite => { :id => nil }})
    end
    
    it "redirects to resource(:invites)" do
      @response.should redirect_to(resource(Invite.first), :message => {:notice => "invite was successfully created"})
    end
    
  end
end

describe "resource(@invite)" do 
  describe "a successful DELETE", :given => "a invite exists" do
     before(:each) do
       @response = request(resource(Invite.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:invites))
     end

   end
end

describe "resource(:invites, :new)" do
  before(:each) do
    @response = request(resource(:invites, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@invite, :edit)", :given => "a invite exists" do
  before(:each) do
    @response = request(resource(Invite.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@invite)", :given => "a invite exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Invite.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @invite = Invite.first
      @response = request(resource(@invite), :method => "PUT", 
        :params => { :invite => {:id => @invite.id} })
    end
  
    it "redirect to the invite show action" do
      @response.should redirect_to(resource(@invite))
    end
  end
  
end

