require 'rails_helper'

RSpec.describe InstructorController, type: :controller do
  describe "GET #instructor" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end


    it "renders the evaluation index" do
      get :index
      expect(response).to render_template("instructor/index")
    end


    it "assigns @instructors" do
        instr = Instructor.create
        get :index
        expect(assigns(:instructors)).to eq([instr])
    end

    it "@instructors is in sorted order by last name" do
        hurley = Instructor.create(name: "Joseph Daniel Hurley")
        daugherity = Instructor.create(name: "Walter Daugherity")
        williams = Instructor.create(name: "Tiffani Williams")
        get :index
        expect(assigns(:instructors)).to eq([daugherity,hurley,williams])
    end
  end

  describe "GET #export" do
    it "redirects back to the index" do
      inst = Instructor.create(name: 'Brent Walther')
      get :export, { id: inst.id }
      expect(response).to redirect_to(instructor_path(inst.id))
    end
  end
end
