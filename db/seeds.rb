# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   start = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
    c = Conference.create!(start_date: Date.parse("2015-4-4"), 
	  end_date: Date.parse("2015-6-6"),
	  max_team_size: 6,
	  min_team_size: 1,
	  max_teams: 5,
	  tamu_cost: 30.00,
	  other_cost: 60.00,
	  challenge_desc: 'yay!',
	  is_active: true
	  )

	new_team = Team.create!(:conference_id => 1,	
	  :school => "TestSchool",
	  :paid_status => "paid", 
	  :team_name => "Winners" 
	  )
	  
	new_team2 = Team.create!(:conference_id => 1,	
	  :school => "TestSchool2",
	  :paid_status => "unpaid", 
	  :team_name => "HelloWorld" 
	  )
	  
	new_participant = Participant.create!(
	  team_id: new_team.id,
	  waiver_signed: true,
	  captain: true,
	  shirt_size: "Medium",
	  phone: "1234567890",
	  account_attributes: {email: "participant@example.com",
	  password: "password",
	  password_confirmation: "password",
	  first_name: "Abram",
	  last_name: "Gutierrez"})
	
	new_participant2 = Participant.create!(
	  team_id: new_team2.id,
	  waiver_signed: false,
	  captain: true,
	  shirt_size: "Large",
	  phone: "1234567890",
	  account_attributes: {email: "participant2@example.com",
		password: "password",
		password_confirmation: "password",
		first_name: "Tian",
		last_name: "Zhang"})
		
	new_participant3 = Participant.create(
	  team_id: new_team2.id,
	  waiver_signed: false,
	  captain: false,
	  shirt_size: "Small",
	  phone: "1234567890",
	  account_attributes: {
	    email: "participant3@example.com",
		password: "password",
		first_name: "John",
		last_name: "Smith"
	  })  	
		
	admin = Administrator.create!(account_attributes:{
		email: "administrator@example.com",
		password: "password",
		password_confirmation: "password",
		first_name: "Abram",
		last_name: "Gutierrez"
		})

	new_participant4 = Participant.create(
	  team_id: new_team.id,
	  waiver_signed: false,
	  captain: false,
	  shirt_size: "Small",
	  phone: "1234567890",
	  account_attributes: {
	    email: "participant4@example.com",
		password: "password",
		first_name: "Jane",
		last_name: "Doe"
	  }) 	
		