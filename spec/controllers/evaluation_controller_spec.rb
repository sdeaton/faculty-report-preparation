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
  end
end
