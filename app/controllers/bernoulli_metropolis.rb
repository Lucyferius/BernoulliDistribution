require_relative 'bernoulli'

class BernoulliMetropolis < Bernoulli
  # @param [float] probability - bernoulli probability of success
  # # @param [int] experiments - count of individual experiments
  def calculate(probability, experiments)
    success = 0
    failure = 0
    return Result.new('Метод Метрополіса', experiments, probability, experiments, 0, probability) if 1.0 == probability
    return Result.new('Метод Метрополіса', experiments, probability, 0, experiments, probability) if 0.0 == probability
    (1..experiments).each do
      x_prev = 0.0
      random_variable = random_variable probability, x_prev
      is_success = success? probability, random_variable.to_f
      is_success ? success += 1 : failure += 1
    end
    Result.new('Метод Метрополіса', experiments, probability, success, failure, (success.to_f/experiments.to_f).round(3))
  end

  # @param [float] prob - bernoulli probability of success
  def random_variable(prob, x_prev)
    x_candidate = x_prev + rand(0.0..1.0)
    alfa = (pdf prob, x_candidate) / (pdf prob, x_prev)
    random_value = rand(0.0..1.0)
    x_candidate if alfa > 1
    if random_value <= alfa
      x_candidate
    else
      random_variable prob, x_prev
    end
  end

end