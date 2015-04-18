# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   start = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
    c = Conference.create(start_date: Date.parse("2015-4-4"), 
	  end_date: Date.parse("2015-6-6"),
	  max_team_size: 6,
	  min_team_size: 1,
	  max_teams: 5,
	  tamu_cost: 30.00,
	  other_cost: 60.00,
	  challenge_desc: 'yay!',
	  is_active: true
	  )

	new_team = Team.create(:conference_id => 1,	
	  :school => "TestSchool",
	  :paid_status => "paid", 
	  :team_name => "Winners" 
	  )
	  
	new_team2 = Team.create(:conference_id => 1,	
	  :school => "TestSchool2",
	  :paid_status => "unpaid", 
	  :team_name => "HelloWorld" 
	  )
	  
	new_participant = Participant.create(
	  team_id: new_team.id,
	  waiver_signed: true,
	  captain: true,
	  shirt_size: "medium",
	  phone: "1234567890")
	
	new_participant2 = Participant.create(
	  team_id: new_team2.id,
	  waiver_signed: false,
	  captain: true,
	  shirt_size: "large",
	  phone: "1234567890")
	  

	Account.create(
		email: "participant@example.com",
		password: "password",
		first_name: "Abram",
		last_name: "Gutierrez",
		user: new_participant

	)
	Account.create(
		email: "participant2@example.com",
		password: "password",
		first_name: "Tian",
		last_name: "Zhang",
		user: new_participant2
	)
	
	Account.create(
		email: "administrator@example.com",
		password: "password",
		first_name: "Abram",
		last_name: "Gutierrez",
		user: Administrator.create()
	)
