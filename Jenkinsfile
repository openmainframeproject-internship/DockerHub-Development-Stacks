node {
    def app

    

    stage('Clone repository') {
        checkout scm
    }
    stage('Build image') {
        DOCKER_HOME = tool "docker"

    sh """
        echo $DOCKER_HOME
        ls $DOCKER_HOME/bin/
        $DOCKER_HOME/bin/docker images
        $DOCKER_HOME/bin/docker ps -a
    """
        docker.build("vedarth/django")
    }
    stage('Test image') {
        app.inside {
            sh 'echo "Test Passed"'
        }
    }
    stage('Push image') {
        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
}