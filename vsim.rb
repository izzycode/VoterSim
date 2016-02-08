require './vsim_module_registry.rb'
require './vsim_module_voting.rb'
require './vsim_classes'

include RegistryActions
include VotingActions
people = []
$poll = {"republicans": 0,"democrats": 0}


polit1 = Politician.new "Lorenzo Lamas","Republican",false
voter1 = Voter.new "Israel Martinez","Democrat",false
voter2 = Voter.new "Jose Gonzalez","Liberal",false
voter3 = Voter.new "Lorax Smith","Neutral",false
polit2 = Politician.new "Willie Nelson","Republican",false
polit3 = Politician.new "Sarah Pailin","Democrat",false
people = [voter1,voter2,voter3,polit1,polit2,polit3]

x = 1
until x == 0
registry_menu(people)
VotingActions::voting_menu(people)


poll.each{ |x| p x}
end
