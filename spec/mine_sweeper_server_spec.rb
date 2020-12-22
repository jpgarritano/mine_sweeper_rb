require "mine_sweeper_server"
require "spec_helper"


describe MineSweeperServer do
    include Rack::Test::Methods

    def app
      MineSweeperServer
    end
    
    context "GET to /solver" do   
      it 'must have problem and solution fields' do
        get "/solver"
        expect(JSON.parse(last_response.body).keys == ["problem", "solution"]).to eq(true)
      end
    end

end