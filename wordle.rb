require "json"
require_relative "./guess"

def list_five_letter_words
  filepath = "data/words_dictionary.json"
  serialized_dictionary = File.read(filepath)
  dictionary = JSON.parse(serialized_dictionary)

  five_letter_hash = dictionary.select {|key, value| key.to_s.length == 5}
  return five_letter_hash.keys
end

def set_word
  five_letter_array = list_five_letter_words()
  return five_letter_array.sample.split("").join("-")
end

def get_input(past_guesses_array)
  past_guesses_array.each do |object|
    array_of_letters = object.validated_word.split("-")
    string = array_of_letters.join(" ")
    puts string
  end
  current_guess = gets.chomp
  return current_guess.split("").join("-")
end

def validate_guess(current_guess)
  five_letter_array = list_five_letter_words()
  # p current_guess.split("-")
  current_guess_length = current_guess.gsub(/[^a-zA-Z]/, '').length
  if current_guess_length == 5 && five_letter_array.include?(current_guess.gsub(/[^a-zA-Z]/, ''))
    # checked_guess = Guess.new(current_guess.split("-"), correct_word.split("-"))
    # all_guesses << checked_guess.validated_word
    # return all_guesses
    return true
  else
    return false
  end
end

def wordle
  # Set the word
  correct_word = set_word()
  # p correct_word
  # Initialize
  guess_counter = 0
  victory = false
  starting_guess = Guess.new(["_", "_", "_", "_", "_"], correct_word.split("-"))
  all_guesses = [starting_guess]

  puts "Welcome to the knockoff wordle!"
  sleep(3)
  while guess_counter < 6 && victory == false do
    system "clear"
    current_guess_string = get_input(all_guesses)
    is_valid = validate_guess(current_guess_string)
    if is_valid == true
      current_guess = Guess.new(current_guess_string.split("-"), correct_word.split("-"))
      all_guesses << current_guess
      victory = true if current_guess.match == true
      guess_counter += 1
    elsif is_valid == false
      puts "Invalid word! Try again..."
      sleep(3)
    end
  end
  puts victory == true ? "You win! It took you #{guess_counter} turns" : "You lose..."
  puts "The correct word was... #{correct_word.split("-").join("")}"
end

wordle()