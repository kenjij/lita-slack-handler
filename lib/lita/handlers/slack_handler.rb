require "lita"

module Lita
	module Handlers
		class SlackHandler < Handler
			# Lita HTTPRoute for Slack: Outgoing WebHook integration
			http.post '/lita/slack-handler', :receive

			# Class method called by Lita for handler configuration
			def self.default_config(default)
				# Slack:Outgoing WebHook integration token
				default.webhook_token = nil
				default.team_domain = nil
				default.ignore_user_name = nil
			end

			def receive(req, res)
				# For security, do not run with missing config
				if not config_valid?
					res.status = 500
					return
				end
				log.debug 'SlackHandler::receive started'
				# Validate request
				if not request_valid?(req)
					res.status = 403
					return
				end
				# Ignore some requests
				if ignore?(req)
					log.debug "SlackHandler::receive ignoring request"
					res.status = 200
					return
				end
				res.status = 200
				log.debug "SlackHandler::receive webhook_token:#{req['token']} team_domain:#{req['team_domain']}"
				log.debug "SlackHandler::receive user id:#{req['user_id']} name:#{req['user_name']}"
				log.debug "SlackHandler::receive room id:#{req['channel_id']} name:#{req['channel_name']}"
				log.debug "SlackHandler::receive message text size #{req['text'].size} byte(s)"
				user = User.create(req['user_id'], name: req['user_name'], mention_name: req['user_name'])
				# Register channel using Lita::User class
				room = User.create(req['channel_id'], name: req['channel_name'])
				source = Source.new(user: user, room: room.id)
				message = Message.new(robot, req['text'], source)
				# Route the message to the adapter
				log.info 'SlackHandler::receive routing message to the adapter'
				robot.receive message
				log.debug 'SlackHandler::receive ending'
			end

			def config_valid?
				valid = true
				if config.webhook_token.nil?
					log.error 'SlackHandler: refuse to run; missing config "webhook_token"'
					valid = false
				end
				if config.team_domain.nil?
					log.error 'SlackHandler: refuse to run; missing "team_domain"'
					valid = false
				end
				return valid
			end

			def request_valid?(req)
				valid = true
				if req['token'] != config.webhook_token
					log.warn "SlackHandler: ignoring request; token does not match (received:#{req['token']})"
					valid = false
				end
				if req['team_domain'] != config.team_domain
					log.warn "SlackHandler: ignoring request; team domain does not match (received:#{req['team_domain']})"
					valid = false
				end
				return valid
			end

			def ignore?(req)
				ignore = false
				if ignored_users.include?(req['user_name'])
					log.warn "SlackHandler: #{req['user_name']} matches ignore_user_name #{config.ignore_user_name}"
					ignore = true
				end
				return ignore
			end

			def ignored_users
			  ['slackbot', config.ignore_user_name].flatten.compact
			end

			#
			# Accessor shortcuts
			#
			def log
				Lita.logger
			end

			def config
				Lita.config.handlers.slack_handler
			end
		end

		Lita.register_handler(SlackHandler)
	end
end
