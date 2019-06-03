class AccountsController < ApplicationController
  def balance
    balance = MturkService.balance

    render json: balance
  end
end
