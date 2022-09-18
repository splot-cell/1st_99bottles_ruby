class Bottles
  def song
    verses(99, 0)
  end

  def verses(starting, ending)
    starting.downto(ending).collect {|i| verse(i)}.join("\n")
  end

  def verse(number)
    bottle_number = BottleNumber.for(number)

    "#{bottle_number} of beer on the wall, ".capitalize +
    "#{bottle_number} of beer.\n" +
    "#{bottle_number.action}, " +
    "#{bottle_number.successor} of beer on the wall.\n"
  end
end

class BottleNumber
  @@registry = [BottleNumber]
  def self.for(number)
    @@registry.find { |candidate| candidate.can_handle(number) }.new(number)
  end

  def self.register(candidate)
    @@registry.unshift(candidate)
  end

  attr_reader :number
  def initialize(number)
    @number = number
  end

  def container
    "bottles"
  end

  def quantity
    number.to_s
  end

  def action
    "Take #{pronoun} down and pass it around"
  end

  def pronoun
    "one"
  end

  def successor
    BottleNumber.for(number - 1)
  end

  def to_s
    "#{quantity} #{container}"
  end

  def self.can_handle(number)
    true
  end
end

class BottleNumber1 < BottleNumber
  def container
    "bottle"
  end

  def pronoun
    "it"
  end

  def self.can_handle(number)
    number == 1
  end
end

BottleNumber.register(BottleNumber1)

class BottleNumber0 < BottleNumber
  def quantity
    "no more"
  end

  def action
    "Go to the store and buy some more"
  end

  def successor
    BottleNumber.for(99)
  end

  def self.can_handle(number)
    number == 0
  end
end

BottleNumber.register(BottleNumber0)

class BottleNumber6 < BottleNumber
  def container
    "six-pack"
  end

  def quantity
    "1"
  end

  def self.can_handle(number)
    number == 6
  end
end

BottleNumber.register(BottleNumber6)
