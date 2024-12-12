module AutoBlog
  module Logging
    def logger
      Logging.logger
    end

    def self.logger
      @logger ||= Logger.new($stderr)
    end

    def self.redirect_output(io)
      logger.reopen(io)
    end
  end
end
