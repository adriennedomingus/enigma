class KeyGenerator
  def initialize(random_number, date)
    @random_number = pad_to_5_digits(random_number)
    @date = date
  end

  def key
    date_key = generate_key_from_date
    random_seed = generate_key_from_random_number
    date_key.zip(random_seed).map {|(x, y)| x + y }
  end

  private

  def pad_to_5_digits(random_number)
    "%05d" % random_number
  end

  def generate_key_from_date
    date_as_number = @date.strftime("%d%m%y").to_i
    date_as_number_squared = date_as_number ** 2
    date_as_number_squared.to_s.chars.last(4).map(&:to_i)
  end

  def generate_key_from_random_number
    [
      @random_number.to_s[0..1].to_i,
      @random_number.to_s[1..2].to_i,
      @random_number.to_s[2..3].to_i,
      @random_number.to_s[3..4].to_i,
    ]
  end
end
