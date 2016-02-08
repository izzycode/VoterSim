require './vsim_module_registry.rb'
require './vsim_classes'
include RegistryActions

module VotingActions

  # Method displays voting menu options and redirects according to selection
  def voting_menu(people)
    draw_a_line
    answer = ask_get "\nWelcome to the polling station.\nWhat is your name?\n"
    var = nil
    people.each {|x| if x.name == answer
      var = x
    end    }
    if var == nil
      error_message
      voting_menu(people)
    else
      ask_vote(var)
    end
    draw_a_line
    puts "\nThank you for your vote! Have a nice day.\n"
    draw_a_line
    puts "\n\tRepublican Votes: #{$poll[:republicans]}\tDemocrat Votes: #{$poll[:democrats]}"
    RegistryActions::registry_menu(people)

  end

  # Method recieves a person object to proceed with voting and returns an updated poll
  def ask_vote(person)
    if person.voted == true
      draw_a_line
      puts "\nThis person has voted already.\n"
      return
    end
    case person.polparty
    when "Republican"
      draw_a_line
      answer = ask_get "\nVote #{person.polparty}?\nConfirm.(Y/N)"
      if (answer.downcase == "y") || (answer.downcase == "yes")
        person.voted = true
        $poll[:republicans] +=1
      else
        person.polparty = "Democrat"
        ask_vote(person)
      end
    when "Democrat"
      draw_a_line
      answer = ask_get "\nVote #{person.polparty}?\nConfirm.(Y/N)"
      if (answer.downcase == "y") || (answer.downcase == "yes")
        person.voted = true
        $poll[:democrats] +=1
      else
        person.polparty = "Republican"
        ask_vote(person)
      end
    else
      draw_a_line
      party = ask_get "\nPlease choose your vote:\n(R)epublican\t(D)emocrat"
      if (party.downcase == "r") || (party.downcase == "republican")
        answer = ask_get "\nVote #{person.polparty}?\nConfirm.(Y/N)"
        if (answer.downcase == "y") || (answer.downcase == "yes")
          person.voted = true
          $poll[:republicans] +=1
        else
          ask_vote(person)
        end
      elsif (party.downcase == "d") || (party.downcase == "democrat")
        if (answer.downcase == "y") || (answer.downcase == "yes")
          person.voted = true
          $poll[:democrats] +=1
        else
          ask_vote(person)
        end
      else
        error_message
        ask_vote(person)
      end
    end
  end

end
