require "json"

def list_five_letter_words
  filepath = "data/words_dictionary.json"
  serialized_dictionary = File.read(filepath)
  dictionary = JSON.parse(serialized_dictionary)

  five_letter_hash = dictionary.select {|key, value| key.to_s.length == 5}
  return five_letter_hash.keys
end

def set_word
  five_letter_array = list_five_letter_words()
  return five_letter_array.sample
end

def get_input(past_guesses_array)
  past_guesses_array.each do |string|
    array_of_letters = string.split("")
    string = array_of_letters.join(" ")
    puts string
  end
  return current_guess = gets.chomp
end

def validate_guess(current_guess, all_guesses, correct_word)
  five_letter_array = list_five_letter_words()
  if current_guess.length == 5 && five_letter_array.include?(current_guess)
    # Check letters here
    all_guesses << current_guess
    return all_guesses
  else
    return false
  end
end

def wordle
  # Initialize
  guess_counter = 0
  victory = false
  all_guesses = ["_____"]

  # Set the word
  correct_word = set_word()

  puts "Welcome to the knockoff wordle!"
  sleep(3)
  while guess_counter < 6 do
    system "clear"
    current_guess = get_input(all_guesses)

    response_to_validation = validate_guess(current_guess, all_guesses, correct_word)
    if response_to_validation != false
      all_guesses = response_to_validation
      guess_counter += 1
    elsif response_to_validation == false
      puts "Invalid word! Try again..."
      sleep(3)
    end
  end
  puts victory == true ? "You win! It took you #{guess_counter} turns" : "You lose..."
end

wordle()