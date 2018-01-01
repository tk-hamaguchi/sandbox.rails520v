# frozen_string_literal: true

module Rails520v
  VERSION = '0.1.0.pre'

  class Version
    def self.app_version
      @app_version ||= Rails520v::VERSION
    end

    def self.db_version
      @db_version ||= ActiveRecord::Migrator.current_version
    end
  end
end
