RailsAdmin.config do |config|

  config.model Tenant do
    create do
      field :name
    end

    edit do
      field :name
      field :users
    end

    list do
      field :id
      field :name
      field :users
      field :created_at do
        strftime_format "%Y-%m-%d %H:%M"
      end
      field :updated_at do
        strftime_format "%Y-%m-%d %H:%M"
      end
    end
  end

  config.model User do
    create do
      field :tenant
      field :name
      field :email
      field :password
      field :password_confirmation
    end

    edit do
      field :tenant
      field :name
      field :email
      field :password
      field :password_confirmation
    end

    list do
      field :id
      field :tenant
      field :name
      field :email do
        formatted_value do
          "#{value[0..value.index('@')]}...#{value[-5..-1]}"
        end
      end
      field :created_at do
        strftime_format "%Y-%m-%d %H:%M"
      end
      field :updated_at do
        strftime_format "%Y-%m-%d %H:%M"
      end
    end

  end

  config.model Admin do
    create do
      field :email
      field :password
      field :password_confirmation
    end

    edit do
      field :email
      field :password
      field :password_confirmation
    end

    list do
      field :id
      field :email do
        formatted_value do
          "#{value[0..value.index('@')]}...#{value[-5..-1]}"
        end
      end
      field :created_at do
        strftime_format "%Y-%m-%d %H:%M"
      end
      field :updated_at do
        strftime_format "%Y-%m-%d %H:%M"
      end
    end

  end

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :admin
  end
  config.current_user_method(&:current_admin)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
