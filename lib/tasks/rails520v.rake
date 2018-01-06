# frozen_string_literal: true

namespace :rails520v do
  namespace :load do
    desc 'Load demo data'
    task demodata: :environment do
      Admin.create_with(
        password: 'P@ssw0rd',
        confirmed_at: Time.zone.now
      ).find_or_create_by!(
        email: 'admin@example.com'
      )
      print "https://localhost:3000/admin/\n"
      print 'You can login with email: "admin@example.com" and password: "P@ssw0rd".'
    end
  end
end
