class Guess
  attr_reader :validated_word, :match

  def initialize(current_guess_array, correct_array)
    @validated_word = validate_word(current_guess_array, correct_array)
    @match = current_guess_array == correct_array
  end

  def validate_word(current_guess_array, correct_array)
    validated_array = []
    correct_letter_counter = 0
    current_guess_array.each_with_index do |letter, index|
      if correct_array[index] == letter
        validated_array << "#{letter}**"
        correct_letter_counter += 1
      elsif correct_array.include? (letter)
        validated_array << "#{letter}*"
      else
        validated_array << letter
      end
    end
    return validated_array.join("-")
  end
end