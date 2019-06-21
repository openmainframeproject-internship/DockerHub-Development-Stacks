node {
    def app

    

    stage('Clone repository') {
        checkout scm
    }
    stage('Build image') {
        DOCKER_HOME = tool "docker"

        docker.build("vedarth/django")
    }

    stage('Push image') {
        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials') {
            app.push("latest")
        }
    }
}