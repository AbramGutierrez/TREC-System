# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   start = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
    Conference.create(start_date: Date.parse("2015-4-4"), 
	  end_date: Date.parse("2015-6-6"),
	  max_team_size: 6,
	  min_team_size: 1,
	  max_teams: 5,
	  tamu_cost: 30.00,
	  other_cost: 60.00,
	  challenge_desc: 'yay!',
	  created_at: DateTime.parse("2015-4-3"),
	  updated_at: DateTime.parse("2015-4-3"),
	  is_active: true
	  )
	  
	Account.create(
		email: "participant@example.com",
		password: "password",
		first_name: "Abram",
		last_name: "Gutierrez",
		user: Participant.create(
			captain: true,
			shirt_size: "medium",
			phone: 1234567890)
	)
	
	Account.create(
		email: "administrator@example.com",
		password: "password",
		first_name: "Abram",
		last_name: "Gutierrez",
		user: Administrator.create()
	)
