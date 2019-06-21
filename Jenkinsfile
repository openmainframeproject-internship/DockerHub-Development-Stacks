node {
    def app
    def app2
    def app3
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
        sh "./base/config.sh"
        sh "mv base/Dockerfile ."
        sh "mv base/sles-15-docker.tar.xz ."
        app3 = docker.build("vedarth/sles")
        sh "mv Dockerfile base/"
        sh "mv sles-15-docker.tar.xz base/"
    }

    stage('Push image') {
        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials') {
            app.push("latest")
            app2.push("latest")
            app3.push("latest")
        }
    }
}