require_relative 'bernoulli'

class BernoulliInverseFunction < Bernoulli
  # @param [float] probability - bernoulli probability of success
  # # @param [int] experiments - count of individual experiments
  def calculate(probability, experiments)
    success = 0
    failure = 0
    return Result.new('Метод зворотної функції', experiments, probability, experiments, 0, probability) if 1.0 == probability
    return Result.new('Метод зворотної функції', experiments, probability, 0, experiments, probability) if 0.0 == probability
    (1..experiments).each do
      random_variable = random_variable probability
      is_success = success? probability, random_variable.to_f
      is_success ? success += 1 : failure += 1
    end
    Result.new('Метод зворотної функції', experiments, probability, success, failure, (success.to_f/experiments.to_f).round(3))
  end

  # @param [float] prob - bernoulli probability of success
  # @return [Float] epsilon
  def random_variable(prob)
    gamma = rand(0.0...1.0)
    dividend = Math.log(gamma * Math.log((prob / (1 - prob)) + 1 - prob) - Math.log(1 - prob))
    divisor = (Math.log(prob) - Math.log(1 - prob))
    (dividend / divisor)
    # убрать перед скрином
    gamma
  end
end
