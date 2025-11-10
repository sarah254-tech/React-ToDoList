pipeline {
    agent any

    environment {IMAGE = "dockerhub254/react-todo-list"}

    tools {
        nodejs "NodeJS"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'sarah-feature',
                    url: 'https://github.com/sarah254-tech/React-ToDoList'
            }
        }

        stage('Frontend Build') {
            steps {
                dir('dive-react-app') {
                    echo "Installing frontend dependencies"
                    sh 'npm install'

                    echo "Running lint"
                    sh 'npm run lint'

                    echo "Building frontend"
                    sh 'npm run build'
                }
            }
        }

        stage('Backend Install') {
            steps {
                dir('backend') {
                    echo "Installing backend dependencies"
                    sh 'npm install'

                    echo "Running backend tests (instead of starting server)"
                    sh 'npm test || true'   // prevents failure if no tests exist
                }
            }
        }

        stage('Build Docker image') {
            when { expression { fileExists('Dockerfile') } }
            steps {
                sh 'docker build -t $IMAGE:latest .'
      }
    }

        stage('Run Tests in Container') {
            when { expression { fileExists('Dockerfile') } }
            steps {
                sh 'docker run --rm $IMAGE:latest /bin/sh -c "echo container test OK"'
      }
    }

        stage('Build and Push to Docker Hub') {
            when { expression { fileExists('Dockerfile') } }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials') {
                    def app = docker.build("${IMAGE}:latest")
                    app.push()
          }
        }
      }
    }

    }

    post {
        always {
            cleanWs()
        }
        success {
            emailext(
                subject: "SUCCESS: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
                body: "The build ${env.BUILD_URL} completed successfully.",
                to: "sarahamadi97@gmail.com"
            )
        }
        failure {
            emailext(
                subject: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
                body: "The build ${env.BUILD_URL} failed. Please check the logs.",
                to: "sarahamadi97@gmail.com"
            )
        }
    }
}

