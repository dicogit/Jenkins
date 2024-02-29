pipeline {
    agent any
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
			agent {
				label 'slave1'
			}
            steps {
                script {
                    echo "PACKAGE STAGE at ${params.Env}"
					sh 'mvn package'
                }
            }
		}
        stage ('DEPLOY') {
            input {
                message 'Run Addressbook Application'
                ok 'Approved'
                parameters {
                    choice(name:'Version', choices:['V1','V2','V3'])
                }
            }
            steps {
                script {
                        echo "DEPLOY STAGE at ${params.Env}"
                    }
                        
            }
		}
                
    }
    
}
    