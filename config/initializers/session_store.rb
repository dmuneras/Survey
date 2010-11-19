# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_encuestaVirtual_session',
  :secret      => 'ed9dc8693c1b96f17d4740dca90a468cac57adfce5eb7deca7f3fc66a824d441cff7155dd4d5cbfc9af05d9fdb99b9cb3f9b4e71d142920f98cb25748af1bd34'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
