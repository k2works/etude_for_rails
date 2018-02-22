node {
        stage("Build") {

            checkout scm

            docker.build('app:base').inside {
           }
            docker.build('app:dev','. -f Dockerfile-dev').inside {
           }
            docker.build('app:test','. -f Dockerfile-test')
        }

        stage("Test") {
            docker.image('mysql:5.7').withRun('-e "MYSQL_ROOT_PASSWORD=password"') { c ->
                docker.image('mysql:5.7').inside("--link ${c.id}:db") {
                    /* Wait until mysql service is up */
                    sh 'while ! mysqladmin ping -hdb --silent; do sleep 1; done'

                }
                docker.image('app:test').inside("--link ${c.id}:db") {
                    sh 'export APP_ROOT=/usr/src/app'
                    sh 'export RAILS_ENV=test'
                    sh '$APP_ROOT/bin/rake db:create'
                    sh '$APP_ROOT/bin/rake db:migrate'
                    sh '$APP_ROOT/bin/rake db:test:prepare'
                    sh '$APP_ROOT/bin/rake spec'
                    sh '$APP_ROOT/bin/rails test'
                    sh '$APP_ROOT & npm test'
                }
            }
        }
}
