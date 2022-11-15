# frozen_string_literal: true

# Home controller
class HomeController < ApplicationController
  before_action :init, only: :result
  before_action :validate_string, only: :result
  before_action :validate_negative_float, only: :result
  before_action :validate_last, only: :result
  before_action :validate_all, only: :result
  def input; end

  def result
    @array = change
    redirect_to root_path, notice: 'Добавьте хотя бы один положительный элемент, не кратный 7' if @elem.nil?
  end

  private

  def init
    @original_array = params[:input]
    @index = 0
  end

  def change
    arr = @original_array.split.map(&:to_f)
    arr.each do |elem|
      if elem.positive? && (elem % 7 != 0)
        @elem = elem
        break
      end
      @index += 1
    end
    arr[@index] = arr.max
    arr
  end

  def validate_string
    flash[:info] = "Исправьте #{@original_array.match(/\D*[^\s\d\-.]/)}" unless
      @original_array.match(/\D*[^\s\d\-.]/).nil?
  end

  def validate_negative_float
    flash[:alert] = 'После "-" и "." должно быть число' unless @original_array.match(/(-\D+|\.\D+)/).nil?
  end

  def validate_all
    redirect_to root_path unless flash.empty?
  end

  def validate_last
    flash[:notice] = 'Последний символ должен быть числом' unless @original_array.match(/\D$/).nil?
  end
end
