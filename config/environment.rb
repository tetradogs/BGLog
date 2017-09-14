# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

Amazon::Ecs.options = {
      associate_tag:     'colmin-22',
      AWS_access_key_id: 'AKIAJGARHJESM4HF3MMQ',
      AWS_secret_key:   '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'
}
