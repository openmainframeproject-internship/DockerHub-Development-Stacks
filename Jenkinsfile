node {
    def app
    def app2
    stage('Clone repository') {
        checkout scm
    }
    stage('Build image') {
        sh "mv django/Dockerfile ."
        DOCKER_HOME = tool "docker"
        app = docker.build("vedarth/django")
        sh "mv Dockerfile django/"
        sh "mv redis/Dockerfile ."
        app2 = docker.build("vedarth/redis")
        sh "mv Dockerfile redis/"
    }

    stage('Push image') {
        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials') {
            app.push("latest")
        }
    }
}