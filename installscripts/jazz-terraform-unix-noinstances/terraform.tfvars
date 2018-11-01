# These variables are set by user input
region = "This is set from the terraform CLI"
github_branch = "REPLACEME"
aws_access_key = "This is set from the terraform CLI"
aws_secret_key = "This is set from the terraform CLI"
jazz_accountid = "REPLACEME"
cognito_pool_username = "REPLACEME"
cognito_pool_password = "REPLACEME"
envPrefix = "replaceme"
tagsEnvironment = "REPLACEME"
tagsExempt = "REPLACEME"
tagsOwner = "REPLACEME"

#Jenkins server map (set programmatically by wizard, not directly by user or terraform)
jenkinsservermap = {
  jenkins_elb = "REPLACEME"
  jenkinsuser = "REPLACEME"
  jenkinspasswd = "REPLACEME"
  jenkins_public_ip = "REPLACEME"
  jenkins_ssh_login = "REPLACEME"
  jenkins_ssh_port = "22"
  jenkins_ssh_key = "../sshkeys/jenkinskey.pem"
  jenkins_security_group = "REPLACEME"
  jenkins_subnet = "REPLACEME"
}

#SCM server map (set programmatically by wizard, not directly by user or terraform)
scmmap = {
  scm_elb = "REPLACEME"
  scm_type = "REPLACEME"
  scm_publicip = "REPLACEME"
  scm_username = "REPLACEME"
  scm_passwd = "REPLACEME"
  scm_privatetoken = "REPLACEME"
  scm_slfid = "REPLACEME"
  scm_pathext = "REPLACEME"
}

#CodeQuality server map (set programmatically by wizard, not directly by user or terraform)
codeqmap = {
  sonar_server_elb = "REPLACEME"
  sonar_username = "REPLACEME"
  sonar_passwd = "REPLACEME"
}

scmbb = true
scmgitlab = false
codeq = false
atlassian_jar_path = "~/jazz_tmp/atlassian-cli-6.7.1/lib/bitbucket-cli-6.7.0.jar"
dockerizedJenkins = true
additional_tags = {}
aws_tags = "[]"
jenkins_docker_image = "jazzserverless/jazzoss-jenkins:1.0.0"
gitlab_docker_image = "gitlab/gitlab-ce:11.3.0-ce.0"
codeq_docker_image = "jazzserverless/jazzoss-sonarqube:1.0.0"
dockerizedSonarqube = false
ecsJenkinscpu = "2048"
ecsJenkinsmemory = "4096"
ecsGitlabcpu = "2048"
ecsGitlabmemory = "4096"
ecsSonarqubecpu = "1024"
ecsSonarqubememory = "2048"
autovpc = false
vpc_cidr_block = "10.0.0.0/16"
existing_vpc_ecs = "replaceme"
