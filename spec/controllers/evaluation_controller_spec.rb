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

  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "assigns @evaluation" do
      get :new
      expect(assigns(:evaluation)).to_not be(nil)
      expect(assigns(:evaluation).instance_of?(Evaluation)).to be(true)
    end

    it "assigns @instructor" do
      FactoryGirl.create(:instructor)
      FactoryGirl.create(:instructor)
      get :new
      expect(assigns(:instructors).count).to be(3) # number of existing instructors + "New Instructor"
    end
  end

  describe "POST #create" do
    it "redirects to the evaluation index page upon evaluation creation" do
      eval = FactoryGirl.build(:evaluation)
      post :create, evaluation: eval.as_json
      expect(response).to redirect_to(evaluation_index_path)
    end

    it "creates a new evaluation if parameters are valid" do
      eval = FactoryGirl.build(:evaluation)
      expect(Evaluation.count).to eq(0)
      post :create, evaluation: eval.as_json
      expect(Evaluation.count).to eq(1)
    end

    it "renders the new page again if params are invalid" do
      eval = FactoryGirl.build(:evaluation, term: "summer")
      post :create, evaluation: eval.as_json
      expect(response).to render_template(:new)
    end

    it "does not create an evaluation if parameters are invalid" do
      eval = FactoryGirl.build(:evaluation, term: "summer")
      expect(Evaluation.count).to eq(0)
      post :create, evaluation: eval.as_json
      expect(Evaluation.count).to eq(0)
    end
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
        eval1 = FactoryGirl.create(:evaluation, course: 110)
        eval2 = FactoryGirl.create(:evaluation, course: 111)
        get :index
        expect(assigns(:evaluation_groups)).to eq([[eval1], [eval2]])
    end

    it "assigns @terms" do
      eval1 = FactoryGirl.create(:evaluation, term: '2015C')
      eval2 = FactoryGirl.create(:evaluation, term: '2015B')
      eval3 = FactoryGirl.create(:evaluation, term: '2015B')
      get :index
      expect(assigns(:terms)).to include(eval1.term)
      expect(assigns(:terms)).to include(eval2.term)
      expect(assigns(:terms).length).to be(2) # should only include unique terms!
    end
  end

  describe "GET #import" do
    it "renders the pretty centered form template" do
      get :import
      expect(response).to render_template 'layouts/centered_form'
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


  describe "PUT #update" do

    before :each do
      @eval1 = FactoryGirl.create(:evaluation, enrollment: 47)
      @eval2 = FactoryGirl.create(:evaluation, enrollment: 22)
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

    it "rejects and redirects back to edit for bad updates" do
      put :update, id: @eval1, evaluation: { enrollment: "45.5" }
      @eval1.reload
      expect(@eval1.enrollment).to eq(47)
      expect(response).to render_template("evaluation/edit")
    end

  end

end
