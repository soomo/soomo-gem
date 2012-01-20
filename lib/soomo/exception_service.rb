module Soomo

  # Public: Proxy to whatever exception service is in use.
  class ExceptionService
    extend Logger

    def self.notify(exception)
      exception = RuntimeError.new(exception) if exception.kind_of?(String)
      app_env = defined?(Rails) ? Rails.env : (ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development')

      case app_env
      when "production", "staging"
        if defined?(Airbrake)
          Airbrake.notify(exception)
        else
          logger.error "#{exception.class.name}: #{exception.message}"
        end
      when "development", "test"
        logger.info "I would notify the ExceptionService, but that doesn't help me.  So, raising exception: #{exception}"
        raise(exception)
      else
        logger.warn "Unrecognized environment: #{app_env}. Not notifying the ExceptionService. Raising instead."
        raise(exception)
      end
    end
  end
end
