class DashboardsController < ApplicationController
  def show
    @users = User
             .includes(assignies: { card: { moves: %i[to next_move] } })
             .joins(:assignies)
             .group(:id).order('count(users.id) desc')
  end
end
