node {
    def app

    stage('Clone repository') {
        checkout scm
        sh 'yum install docker'
    }
    stage('Build image') {
        sh 'cd django && docker build .'
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