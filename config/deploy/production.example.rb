server '',
       user: 'deploy',
       port: 22,
       roles: %w{app db web}

set :web_servers,
    %w{example.domain.com example2.domain.com}
