class Bernoulli
  Result = Struct.new(:name, :experiments, :probability, :success, :failure, :mean_success)
  # @param [float] probability - probability
  # @param [float] variable - random variable
  def success?(probability, variable)
    variable < probability
  end

  def pdf(prob, var)
    (prob**var) * ((1 - prob)**(1 - var))
  end

  # дисперсия
  # мера того, насколько далеко набор чисел разбросан от их среднего значения
  def variance(prob)
    prob * (1 - prob)
  end

  # коеф. ассиметрии
  # если минусовой то маса состредоточена правее и наоборот
  # если минусовой значит среднее значение отклоняется вправо (в нашем случае p на графике выше)
  def skewness(prob)
    (1 - 2 * prob) / Math.sqrt(variance(prob))
  end

  # среднее/ мат. ожидание
  def mean_formal(prob)
    prob
  end

  def mean_informal(success, experiments)
    success.to_f / experiments.to_f
  end

  # часто встречаемое значчение
  def mode(prob)
    return 1 if prob > 0.5
    return 0 if prob < 0.5
    return 0.5 if prob == 0.5
  end
end
