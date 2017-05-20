node {
        stage("Build") {

            checkout scm

            docker.build('app:base').inside {
           }
        }

        stage("Test") {

            docker.build('app','. -f Dockerfile-dev').inside {
           }

           sh './bin/yarn'
           sh './bin/webpack'
           sh './bin/rails assets:precompile'
           sh 'xvfb-run ./bin/rails test:system'

        }
}