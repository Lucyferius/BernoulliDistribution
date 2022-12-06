require_relative 'bernoulli'
require_relative 'bernoulli_neumann'
require_relative 'bernoulli_inverse_function'
require_relative 'bernoulli_metropolis'


class BernouliesController < ApplicationController
  helper :all
  before_action :validate_params, only: [:post]

  def validate_params
    if params[:anything][:prob].to_f < 0.0 or params[:anything][:prob].to_f > 1.0
      @prob_error = 'Допустимий діапазон ймовірності: 0 ≤ p ≤ 1'
      render :template => 'bernoulies/index'
    end
  end

  def get
    render :template => 'bernoulies/index'
  end

  def post
    @prob = params[:anything][:prob].to_f
    @q_prob = 1.0 - @prob
    @prob_and_q_prob_dataset = [@q_prob, @prob]

    @experiments = params[:anything][:experiments].to_i

    bernoulli_neumann = BernoulliNeumann.new
    @bernoulli_neumann_result = bernoulli_neumann.calculate @prob, @experiments

    bernoulli_inverse_function = BernoulliInverseFunction.new
    @bernoulli_inverse_result = bernoulli_inverse_function.calculate @prob, @experiments

    bernoulli_metropolis = BernoulliMetropolis.new
    @metropolis_method_result = bernoulli_metropolis.calculate @prob, @experiments

    bernoulli_main = Bernoulli.new
    @variance = bernoulli_main.variance(@prob)
    @mode = bernoulli_main.mode(@prob)
    @mean_formal = bernoulli_main.mean_formal(@prob)
    @skewness = bernoulli_main.skewness(@prob).round(3)

    @message = 'Розраховано!'
    render :template => 'bernoulies/index'
  end
end
