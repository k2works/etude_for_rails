role :server, %w(127.0.0.1)
set(
    :ssh_options,
    port: 2222,
    auth_methods: %w(publickey),
    keys: [File.expand_path("../../../ops/01_development/.vagrant/machines/default/virtualbox/private_key", __FILE__)],
    user: "vagrant"
)