require 'rails_helper'

RSpec.describe EvaluationController, type: :controller do
  describe "GET #evaluation" do
      
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
        eval = Evaluation.create
        get :index
        expect(assigns(:evaluations)).to eq([eval])
    end


    it "renders the edit template" do
      Evaluation.create
      get :edit, id: 1
      expect(response).to render_template("evaluation/edit")
    end

  end


  describe "PUT #evaluation" do

    before :each do
      instructor = Instructor.create(name: 'xyz')
      @eval1=Evaluation.create(
        term: '2015C',
        subject: 'CSCE',
        course: '110',
        section: '500' ,
        instructor: instructor ,
        enrollment: '47',
      )
      @eval2=Evaluation.create(
        term: '2015C',
        subject: 'CSCE',
        course: '111',
        section: '501' ,
        instructor: instructor ,
        enrollment: '22',
      )
    end

    it "updates the enrollment and redirects to evaluation page  " do
      put :update, id: @eval1, :evaluation=>{:enrollment=>"44"}
      @eval1.reload
      @eval1.enrollment.should eq (44)
      expect(response).to redirect_to('/evaluation')
    end


    it "edits the correct row and redirects to evaluation page" do
      put :update, id: @eval1, :evaluation=>{:enrollment=>"54"}
      @eval1.reload
      @eval2.reload
      @eval1.enrollment.should eq (54)
      @eval2.enrollment.should eq (22)
      expect(response).to redirect_to('/evaluation')
    end

  end

end 
