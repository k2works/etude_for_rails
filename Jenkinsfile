node {
        stage("Build") {

            checkout scm

            docker.build('app:base').inside {
           }
            docker.build('app:dev','. -f Dockerfile-dev').inside {
           }
        }

        stage("Test") {
            docker.image('mysql:7').withRun('-e "MYSQL_ROOT_PASSWORD=password"') { c ->
                docker.image('mysql:7').inside("--link ${c.id}:db") {
                    /* Wait until mysql service is up */
                    sh 'while ! mysqladmin ping -hdb --silent; do sleep 1; done'
                }
                docker.build('app:test','. -f Dockerfile-test').inside("--link ${c.id}:db") {
                }
            }
        }
}
