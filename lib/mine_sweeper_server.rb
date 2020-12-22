
require 'bundler'
Bundler.require
require_relative 'mine_sweeper'
require 'sinatra/base'

class MineSweeperServer < Sinatra::Base

before do
  content_type 'application/json'
end

get '/solver' do
    #minimo 3x3
    mine_sweeper = MineSweeper.new([3,rand(ENV.fetch('MINE_MAX_SIZE',45).to_i)].max)
    response = {
        :problem => mine_sweeper.build_problem,
        :solution => mine_sweeper.print_solution
    }
    response.to_json
end

end