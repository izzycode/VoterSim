# class Person
class Person
  @@num_of_people = 0
  attr_accessor :name ,:polparty, :voted
  def initialize(name,voted)
    @name = name
    @@num_of_people += 1
  end
  def self.how_many
    @@num_of_people
  end
  def self.delete_person
    @@num_of_people -=1
  end
end

# class Voter inherits class Person and adds own identifier
class Voter < Person
  attr_accessor :polparty
  @@num_of_voters = 0
  def initialize(name,polParty,voted)
    super(name,voted)
    @polparty = polParty
    @@num_of_voters += 1
  end
  def self.delete_voter
    @@num_of_voters -=1
    Person.delete_person
  end
end

# class Politician inherits from class Voter and adds own identifier
class Politician < Person
  attr_reader :polparty
  @@num_of_politicians = 0
  def initialize(name,polParty,voted)
    super(name,voted)
    @polparty = polParty
    @@num_of_politicians += 1
  end
  def self.delete_politician
    @@num_of_politicians -=1
    Person.delete_person
  end
end

#
# person1 = Person.new "Israel","Martinez"
# voter1 = Voter.new "Israel","Martinez"
# voter2 = Voter.new "Jose","Gonzalez"
# voter3 = Voter.new "Lorax","Smith"
