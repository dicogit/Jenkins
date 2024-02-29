pipeline {
    agent any 
	environments {
		remote1="ec2-user@65.0.20.163"
	}
	tools {
		maven 'mymaven'
	}     
    parameters {
        string (name:'Env', defaultValue:'Linux', description:'Linux Env')
        booleanParam(name:'polar', defaultValue:true, description:'conditional')
        choice(name:'poll', choices:[7,8,9], description:'selection')
    }
    stages {
        stage ('COMPILE') {
            steps {
                script {
                    echo "COMPILE STAGE at ${params.Env}"
                    sh 'mvn compile'
                }
            }
        }
        stage ('TEST') {
            when {
                expression {
                    params.polar == true
                }
            }
            steps {
                script {
                    echo "TEST STAGE at ${params.Env}"
                    sh 'mvn test'
                }
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage ('PACKAGE') {
            steps {
                sshagent(['slave1']) {
                    script {
                        echo "PACKAGE STAGE at ${params.Env}"
                            sh "scp -o StrictHostKeyChecking=no server_cfg.sh ${remote1}:/home/ec2-user/"
                            sh "ssh -o StrictHostKeyChecking=no ${remote1} 'bash ~/server_cfg.sh'"
                                     
                    }

                }
                
            }
        }
        
    }
    
}