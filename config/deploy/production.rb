# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

#role :app, %w{deploy@190.4.89.88}
#role :web, %w{deploy@190.4.89.88}
#role :db,  %w{deploy@190.4.89.88}

#server "190.4.89.88", :app, :web, :db, :primary => true

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

#server 'example.com', user: 'deploy', roles: %w{web app}, my_property: :my_value


server '190.4.89.88',
       user: 'deploy',
       roles: %w{web app db},
       port: 22,
       password: 'apJagNiho'

#set :ssh_options, { auth_methods: %w(password) }

# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# And/or per server (overrides global)
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }

set :ssh_options, {
    forward_agent: false,
    auth_methods: %w(password),
    password: 'apJagNiho',
    user: 'deployer',
}

set :bundle_env_variables, { 'NOKOGIRI_USE_SYSTEM_LIBRARIES' => 1 }