node {
    // Define your ECR repository URI
    def ECR_REPOSITORY_URI = 'your-ecr-repository-uri'

    stage('Clone repo') {
        checkout scm
    }
    
    stage('Build the image and add timestap as tag') {
        // Build the Maven project
        sh 'mvn clean package'
        
        // Build the Docker image with current timestamp as tag
        script {
            def timestamp = new Date().getTime() / 1000
            def imageNameWithTag = "cicd-devops-gitops-${timestamp}"
            env.IMAGE_NAME = "${imageNameWithTag}"
            sh "docker build -t ${imageNameWithTag} ."
            env.IMAGE_TAG = "${timestamp}"
        }
    }
    
    stage('Push the built image to ECR') {
        // Push the Docker image to ECR
        sh "docker push $ECR_REPOSITORY_URI:${env.IMAGE_NAME}"
    }
    
    stage('Post-build: Send the latest image tag to the drownstream job') {
        // Trigger downstream job passing the IMAGE_TAG parameter
        build job: 'updatek8smanifest', parameters: [string(name: 'IMAGE_TAG', value: env.IMAGE_TAG)]
    }
}
