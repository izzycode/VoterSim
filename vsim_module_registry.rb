require "./colored.rb"

module RegistryActions

  # Method menu for
  def registry_menu(people)
    draw_a_line
    menuOptions = ask_get "\nWhat would you like to do?\n(C)reate\n(L)ist Registry\n(U)pdate\n(D)elete a Registration\n(V)ote\n(E)xit"
    case menuOptions.downcase
    when "c"
      gets_info(people)
      registry_menu(people)
    when "l"
      list_registrations(people)
      registry_menu(people)
    when "u"
      update_registration(people)
      registry_menu(people)
    when "d"
      delete_registration(people)
      registry_menu(people)
    when "v"
      VotingActions::voting_menu(people)
    when "e"
      exit
    else
      print `clear`
      error_message
      registry_menu(people)
    end
  end

  # Method draws a line
  def draw_a_line
    puts
    30.times { print "_-".red}
    puts
  end
  # Method displays an error message
  def error_message
    puts "\n\nThat is not a valid option. Please try again.".reversed
    draw_a_line
  end

  # Method outputs questin and returns answer
  def ask_get(question)
    puts question
    gets.chomp
  end

  # Method that returns users coice of Voter or Politician
  def peopleVSpolitician
    choice = ask_get "Are you going to register as a (V)oter or a (P)olitician?"
    if (choice == "politician") || (choice == "p")
      return "Politician"
    elsif (choice == "voter") || (choice == "v")
      return "Voter"
    else
      error_message
      peopleVSpolitician
    end
  end

  # Method returns affiliation or political party
  def chooseAffiliationOrParty(iam)
    draw_a_line
    if iam == "Voter"
      political_preference = ask_get "\nPlease choose:\n\n(L)iberal, (C)onservative, (T)ea Party, (S)ocialist, or (N)eutral"
      if (political_preference.downcase == "l") || (political_preference.downcase == "liberal")
        return "Liberal"
      elsif (political_preference.downcase == "c") || (political_preference.downcase == "conservative")
        return "Conservative"
      elsif (political_preference.downcase == "t") || (political_preference.downcase == "tea party")
        return "Tea Party"
      elsif (political_preference.downcase == "s") || (political_preference.downcase == "socialist")
        return "Socialist"
      elsif (political_preference.downcase == "n") || (political_preference.downcase == "neutral")
        return "Neutral"
      else
        error_message
        chooseAffiliationOrParty(iam)
      end
    else
      political_preference = ask_get "\nPlease choose your party affiliation:\n(R)epublican\t(D)emocrat"
      if (political_preference.downcase == "r") || (political_preference.downcase == "republican")
        return "Republican"
      elsif (political_preference.downcase == "d") || (political_preference.downcase == "democrat")
        return "Democrat"
      else
        error_message
        chooseAffiliationOrParty(iam)
      end
    end
  end

  # Method creates a new registration with user input
  def gets_info(people,*pre_politics)
    draw_a_line
    if pre_politics.any?
      affiliationORparty = chooseAffiliationOrParty(pre_politics[0])
      # peopleORpolitician = chooseAffiliationOrParty(pre_politics)
    else
      peopleORpolitician = peopleVSpolitician
      affiliationORparty = chooseAffiliationOrParty(peopleORpolitician)
    end
    # affiliationORparty = chooseAffiliationOrParty(peopleORpolitician)
    name = (ask_get "Please enter name: ")
    if (peopleORpolitician == "Voter") || (pre_politics[0] == "Voter")
      people << Voter.new(name,affiliationORparty,false)
    else
      people << Politician.new(name,affiliationORparty,false)
    end
  end

  # Method lists all entries
  def list_registrations(people)
    draw_a_line
    people.each {|x| print "\n#{x.class.to_s}, #{x.name}, #{x.polparty}"}
  end

  # Method updates entries
  def update_registration(people)
    draw_a_line
    answer = ask_get "Who would you like to update?"
    var = nil
    people.each {|x| if x.name == answer
      var = x
      people.delete x
    end    }
    if var == nil
      error_message
      update_registration(people)
    else
      puts "\nEnter the updated data."
      if var.class.to_s == "Voter"
        gets_info(people,"Voter")
      else
        get_info(people,"Politician")
      end
    end
  end

  # Method delete action
  def delete_action(people,answer)
    p "inside delete action"
    new_list = people.map {|x| if (x.name != answer)
                        x
                      end}
  end

  # Method Deletes from list of people
  def delete_registration(people)
    draw_a_line
    answer = ask_get "Delete a (P)olitician or a (V)oter?"
    if (answer.downcase == "p") || (answer.downcase == "politician")
      draw_a_line
      puts "Here is the list of registered Politicians:"
      people.each {|x| if x.class.to_s == "Politician"
                          puts "#{x.name}" end}
      draw_a_line
      answer = ask_get "Which would you like to delete?"
      var = nil
      people.each {|x| if x.name == answer
        var = x
        people.delete x
      end    }
      if var == nil
        error_message
        delete_registration(people)
      end
      y_or_n = ask_get "Are you sure? (Y/N)"
      case y_or_n.downcase
      when "y"
        Politician.delete_politician
        registry_menu (delete_action(people,answer))
      when "n"
        registry_menu(people)
      else
        error_message
        registry_menu(people)
      end
    elsif (answer.downcase == "v") || (answer.downcase == "voter")
      draw_a_line
      puts "Here is the list of registered Voters:"
      people.each {|x| if x.class.to_s == "Voter"
                          puts "#{x.name}" end}
      draw_a_line
      answer = ask_get "Which would you like to delete?"
      var = nil
      people.each {|x| if x.name == answer
        var = x
        people.delete x
      end    }
      if var == nil
        error_message
        delete_registration(people)
      end
      y_or_n = ask_get "Are you sure? (Y/N)"
      case y_or_n.downcase
      when "y"
        Voter.delete_voter
        registry_menu(delete_action(people,answer))
      when "n"
        registry_menu(people)
      else
        error_message
        registry_menu(people)
      end
    #  people.map! {|x| x.name != answer}
    else
      draw_a_line
      error_message
      delete_registration(people)
    end

  end

end
