require 'rails_helper'

RSpec.describe Instructor, type: :model do
  describe ".select_menu_options" do
    it "includes all instructors and a new instructor option" do
      Instructor.create(name: 'Brent Walther')
      expect(Instructor.select_menu_options.size).to eq(2)
    end
  end
end
