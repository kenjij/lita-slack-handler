require "spec_helper"

describe Lita::Handlers::SlackHandler, lita_handler: true do
	http_route_path = '/lita/slack-handler'
	req = {}
	
	it "registers with Lita" do
		expect(Lita.handlers).to include(described_class)
	end

	it "registers HTTP route POST #{http_route_path} to :receive" do
		expect(described_class.http_routes[0].http_method).to eql('POST')
		expect(described_class.http_routes[0].path).to eql(http_route_path)
		expect(described_class.http_routes[0].method_name).to eql(:receive)
	end

	context "with valid config" do
		before :each do
		  Lita.config.handlers.slack_handler.webhook_token = "aN1NvAlIdDuMmYt0k3n"
		  Lita.config.handlers.slack_handler.team_domain = "example"
		end
		
		describe "#config_valid?" do
			it 'returns true' do
				expect(subject.config_valid?).to eql(true)
			end
		end
		
		describe "#request_valid?" do
			it 'returns true with valid request' do
				req['token'] = Lita.config.handlers.slack_handler.webhook_token
				req['team_domain'] = Lita.config.handlers.slack_handler.team_domain
				expect(subject.request_valid?(req)).to eql(true)
			end
		end

		describe "#request_valid?" do
			it 'returns false with invalid token request' do
				req['token'] = 'fUnKyT0K3N'
				req['team_domain'] = Lita.config.handlers.slack_handler.team_domain
				expect(subject.request_valid?(req)).to eql(false)
			end

			it 'returns false with invalid team_domain request' do
				req['token'] = Lita.config.handlers.slack_handler.webhook_token
				req['team_domain'] = 'my'
				expect(subject.request_valid?(req)).to eql(false)
			end
		end
	end

	context "without valid config" do
		before :each do
		  Lita.config.handlers.slack_handler.webhook_token = nil
		  Lita.config.handlers.slack_handler.team_domain = nil
		end
		
		describe "#config_valid?" do
			it 'returns false' do
				expect(subject.config_valid?).to eql(false)
			end
		end
	end
end