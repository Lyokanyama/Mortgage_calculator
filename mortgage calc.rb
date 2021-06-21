require 'yaml'
MESSAGES = YAML.load_file('mortgage_messages.yml')

def messages(message)
  MESSAGES[message]
end

def prompt(key = '', literal = '')
  message = messages(key)
  puts("=> #{message} #{literal}")
end

def valid_number?(input)
  input.to_f.to_s == input || input.to_i.to_s == input
end

prompt('welcome')

loop do # main loop
  loan_amount = ''
  loop do # Loan amount loop
    prompt('loan_amount')
    loan_amount = gets.chomp

    if valid_number?(loan_amount)
      break
    else
      prompt('invalid_number')
    end
  end

  loan_interest = ''
  loop do # loan interest loop
    prompt('loan_interest')
    loan_interest = gets.chomp

    if valid_number?(loan_interest)
      break
    else
      prompt('invalid_number')
    end
  end

  loan_term_years = ''
  loop do # Loan term years loop
	  prompt('loan_term_years')
    loan_term_years = gets.chomp

   if valid_number?(loan_term_years)
     break
   else
     prompt('invalid_number')
   end
  end

  annual_interest_rate = loan_interest.to_f / 100
  monthly_interest_rate = annual_interest_rate / 12
  months = loan_term_years.to_i * 12

  monthly_payment = loan_amount.to_f *
                    (monthly_interest_rate /
                    (1 - (1 + monthly_interest_rate)**(-months)))

  prompt('monthly_payment', "$#{format('%.2f', monthly_payment)}")

  prompt('again')
  response = gets.chomp

  break unless response.downcase.start_with?('y')
end

prompt('Goodbye')
