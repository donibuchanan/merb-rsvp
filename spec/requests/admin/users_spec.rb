require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe "/admin/users" do
  before(:each) do
    @response = request("/admin/users")
  end
end