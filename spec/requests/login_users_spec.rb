#encodigin: utf-8
require 'spec_helper' 
include Capybara::DSL 
                         
def put_user(admin=nil)
  
  user = FactoryGirl.create(:user, admin: true)
  visit root_path
  click_link "Entrar"
  fill_in "Email", :with => user.email
  fill_in "Password", :with => user.password
  click_button "Entrar"
  
end       
       
describe "LoginUsers" do
  it "logar usuario admin" do
      
      put_user(true)
      current_path.should eq(magazines_path)
      # assert user.admin?, "Usuario deve ser administrador!"
    end 
  #         
  it "logar usuario nao administrador" do
      
    put_user(false)
    current_path.should eq(magazines_path)
    # assert user.admin?, "Usuario deve ser administrador!"
  end 

  
end

