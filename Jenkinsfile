node('suse') {
    def app
    def app2
    def app3
    def app4
    def app5
    stage('Clone repository') {
        checkout scm
    }
    stage('Build image') {
        DOCKER_HOME = tool "docker"
        sh "cd base && sudo ./config.sh && cd .."
        sh "mv base/Dockerfile ."
        sh "mv base/sles-15-docker.tar.xz ."
        app3 = docker.build("vedarth/sles")
        sh "mv Dockerfile base/"
        sh "mv sles-15-docker.tar.xz base/"
        sh "mv django/Dockerfile ."
        app = docker.build("vedarth/django")
        sh "mv Dockerfile django/"
        sh "mv redis/Dockerfile ."
        app2 = docker.build("vedarth/redis")
        sh "mv Dockerfile redis/"
        sh "mv golang/Dockerfile ."
        sh "mv golang/go-wrapper ."
        app4 = docker.build("vedarth/golang")
        sh "mv Dockerfile golang/"
        sh "mv go-wrapper golang/"
        sh "mv jupyter/Dockerfile ."
        app5 = docker.build("vedarth/jupyter")
        sh "mv Dockerfile jupyter/"
    }
}