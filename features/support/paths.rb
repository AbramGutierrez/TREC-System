# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'
	
	when /^the Log in page/
	  '/login'
	  
	when /^the register page/
	  '/registrations'	  
	  
	when /^the participant dashboard/
      '/participant/dashboard'	
	  
	when /^the administrator dashboard/
      '/administrator/dashboard'

	when /^the teams page/
	  '/teams'

	when /^the conferences page/
	  '/conferences'  
	
	when /^the sponsors page/
	  '/sponsors'
	
	when /^the schools page/
	  '/schools'
	
	when /^the send message page/
	  '/messenger'
	  
	when /^the conference show page/
	  '/conferences/1'

	when /^the team show page/
	  '/teams/1'
	  
	when /^the team edit page/
	  '/teams/1/edit'  
	  
	when /^the team invalid edit page/
	  '/teams/1'   

	when /^the participant show page/
	  '/participants/1'  
	  
	when /^the team members page/
	  '/team_members/1'	
	  
	when /^the participant new page/
	  '/participants/new'

	when /^the participant edit page/
	  '/participants/1/edit'

	when /^the participant invalid edit page/
	  '/participants/1'	
	  
	when /^the participants page/
	  '/participants'	
	
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
