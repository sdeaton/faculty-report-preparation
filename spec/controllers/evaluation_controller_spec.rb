require 'rails_helper'

RSpec.describe EvaluationController, type: :controller do

  it "redirects the user to the login page if they are unauthenticated" do
    sign_out @user
    get :index
    expect(response).to redirect_to(new_user_session_path)
  end

  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end


    it "renders the evaluation index" do
      get :index
      expect(response).to render_template("evaluation/index")
    end


    it "assigns @evaluations" do
        eval = FactoryGirl.create(:evaluation)
        get :index
        expect(assigns(:evaluation_groups)).to eq([[eval]])
    end
  end

  describe "GET #export" do
    it "redirects back to the index" do
      get :export
      expect(response).to redirect_to(evaluation_index_path)
    end
  end


  describe "GET #edit" do
    it "renders the edit template" do
      FactoryGirl.create(:evaluation)
      get :edit, id: 1
      expect(response).to render_template("evaluation/edit")
    end
  end


  describe "PUT #evaluation" do

    before :each do
      # instructor = Instructor.create(name: 'xyz')
      @eval1 = FactoryGirl.create(:evaluation, enrollment: 47)

      @eval2 = FactoryGirl.create(:evaluation, enrollment: 22)
      # @eval2=Evaluation.create(
      #   term: '2015C',
      #   subject: 'CSCE',
      #   course: '111',
      #   section: '501' ,
      #   instructor: instructor ,
      #   enrollment: '22',
      # )
    end

    it "updates the enrollment and redirects to evaluation page  " do
      put :update, id: @eval1, :evaluation=>{:enrollment=>"44"}
      @eval1.reload
      expect(@eval1.enrollment).to eq (44)
      expect(response).to redirect_to('/evaluation')
    end


    it "edits the correct row and redirects to evaluation page" do
      put :update, id: @eval1, :evaluation=>{:enrollment=>"54"}
      @eval1.reload
      @eval2.reload
      expect(@eval1.enrollment).to eq (54)
      expect(@eval2.enrollment).to eq (22)
      expect(response).to redirect_to('/evaluation')
    end

  end

end
