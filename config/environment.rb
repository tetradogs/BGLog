# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

Amazon::Ecs.options = {
      associate_tag:     'colmin-22',
      AWS_access_key_id: 'AKIAJWPQNTIKR2RTYUTA',
      AWS_secret_key:   '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'
}
