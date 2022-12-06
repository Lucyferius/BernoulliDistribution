require_relative 'bernoulli'

class BernoulliNeumann < Bernoulli
  # @param [float] probability - probability
  # # @param [int] experiments - count of individual experiments
  def calculate(probability, experiments)
    success = 0
    failure = 0
    return Result.new('Метод Неймана', experiments, probability, experiments, 0, probability) if 1.0 == probability
    return Result.new('Метод Неймана', experiments, probability, 0, experiments, probability) if 0.0 == probability

    pdf_max = calculate_pdf_max probability
    (1..experiments).each do
      random_variable = random_variable probability, pdf_max
      is_success = success? probability, random_variable.to_f
      is_success ? success += 1 : failure += 1
    end
    Result.new('Метод Неймана', experiments, probability, success, failure, (success.to_f/experiments.to_f).round(3))
  end

  # @param [float] probability - bernoulli probability of success
  # @param [float] pdf_max - calculated max W
  def random_variable(probability, pdf_max)
    x_i = rand(0.0..1.0)
    y_i = pdf_max * rand(0.0..1.0)
    if (pdf probability, x_i) > y_i
      x_i
    else
      random_variable probability, pdf_max
    end
  end

  # @param [float] prob - bernoulli probability of success
  def calculate_pdf_max(prob)
    pdf_max = 0.0
    segments = 1000
    (0..segments).each do |i|
      candidate = pdf prob, (i / segments)
      pdf_max = candidate if candidate > pdf_max
    end
    pdf_max
  end
end
