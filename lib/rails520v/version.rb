module Rails520v
  VERSION = '0.1.0.pre'

  class Version
    cattr_accessor :app_version

    @@app_version = Rails520v::VERSION

    def self.db_version
      @@db_version ||= ActiveRecord::Migrator.current_version
    end
  end
end
