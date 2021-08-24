#!/usr/bin/env groovy

def notify_channel = "#jenkins-notify"
def label = "jenkins-vg-agent"
def aws_region = "ap-southeast-1"
env.terraform_version = "0.12.31"

def build_info = "Job: ${env.JOB_NAME}, Build: #${env.BUILD_NUMBER}."

properties([parameters([
        choice(choices: ["create", "remove"].join("\n"), description: "Create or remove cluster", name: "terraform_action")
])])

podTemplate(label: label, containers: [
        containerTemplate(name: 'jenkins-agent',
                image: "greghu/terraform-0.12.31:latest",
                ttyEnabled: true,
                command: 'cat')
]) {
    node(label) {
        withAWS(credentials: 'aws-id', region: 'ap-southeast-1') {
            stage('Notify') {
                slackSend channel: "${notify_channel}", color: "warning", message: "EKS cluster updating ${build_info} (<${env.BUILD_URL}|see details>)"
            }

            container('jenkins-agent') {
                    stage('Checkout') {
                       checkout scm
                    }

                    stage('Init') {
                        dir("terraform-eks") {
                            sh 'terraform init -input=false'
                        }
                    }

                    stage('Validate') {
                        dir("terraform-eks") {
                            sh 'terraform validate'
                        }
                    }

                    stage('Fmt') {
                        dir("terraform-eks") {
                            sh 'terraform fmt'
                        }
                    }

                    stage('Plan') {
                        dir("terraform-eks") {
                            sh 'terraform plan -out=tfplan -input=false'
                        }
                    }

                    stage('Apply') {
                        dir("terraform-eks") {
                            if (env.terraform_action == "create") {
                                sh 'terraform apply -input=false tfplan'
                            } else {
                                echo "Skip Apply due to not match."
                            }
                        }
                    }

                    stage('Destroy') {
                        dir("terraform-eks") {
                            if (env.terraform_action == "remove") {
                                sh 'terraform plan -destroy'
                            } else {
                                echo "Skip Destroy due to not match."
                            }
                        }
                    }

                    stage('Notify') {
                        slackSend channel: "${notify_channel}", color: "good", message: "EKS cluster updated ${build_info} (<${env.BUILD_URL}|see details>)"
                    }
            }
        }
    }
}