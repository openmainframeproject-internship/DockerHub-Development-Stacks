node {
    def app

    

    stage('Clone repository') {
        checkout scm
    }
    stage('Build image') {
        DOCKER_HOME = tool "docker"

        sh "cd django && docker build ."
    }

    stage('Push image') {
        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials') {
            app.push("latest")
        }
    }
}