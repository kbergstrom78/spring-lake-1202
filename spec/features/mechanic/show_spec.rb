require "rails_helper"

RSpec.describe "mechanic#show", type: :feature do
  let!(:ap_1) { AmusementPark.create!(name: "Wally World", admission_cost: 50) }
  let!(:ride_1) { ap_1.rides.create!(name: "Rattler", thrill_rating: 5, open: true) }
  let!(:ride_2) { ap_1.rides.create!(name: "Lazy River", thrill_rating: 1, open: true) }
  let!(:ride_3) { ap_1.rides.create!(name: "Thunder Mountain RR", thrill_rating: 10, open: true) }
  let!(:mechanic_1) { Mechanic.create!(name: "Bubba Gump", years_experience: 10) }

  let!(:ride_mechanic_1) { RideMechanic.create!(ride_id: ride_1.id, mechanic_id: mechanic_1.id) }
  let!(:ride_mechanic_2) { RideMechanic.create!(ride_id: ride_2.id, mechanic_id: mechanic_1.id) }

  it "displays the amusement park's name and admission price" do
    visit amusement_park_path(amusement_park)

    expect(page).to have_content(amusement_park.name)
    expect(page).to have_content("Admission Price: #{amusement_park.admission_cost}")
  end

  it "displays the names of mechanics working on the amusement park's rides" do
    visit amusement_park_path(amusement_park)

    amusement_park.mechanics.each do |mechanic|
      expect(page).to have_content(mechanic.name)
    end
  end

  it "displays a list of unique mechanics working on the amusement park's rides" do
    visit amusement_park_path(amusement_park)

    mechanics = amusement_park.mechanics.distinct

    mechanics.each do |mechanic|
      expect(page).to have_content(mechanic.name)
    end
  end
end