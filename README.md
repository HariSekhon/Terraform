# Terraform Templates

[![GitHub stars](https://img.shields.io/github/stars/HariSekhon/Terraform?logo=github)](https://github.com/HariSekhon/Terraform//stargazers)
[![GitHub forks](https://img.shields.io/github/forks/HariSekhon/Terraform?logo=github)](https://github.com/HariSekhon/Terraform/network)
[![Lines of Code](https://img.shields.io/badge/lines%20of%20code-2k-lightgrey?logo=codecademy)](https://github.com/HariSekhon/Terraform)
[![License](https://img.shields.io/github/license/HariSekhon/Terraform)](https://github.com/HariSekhon/Terraform/blob/master/LICENSE)
[![My LinkedIn](https://img.shields.io/badge/LinkedIn%20Profile-HariSekhon-blue?logo=linkedin)](https://www.linkedin.com/in/HariSekhon/)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/HariSekhon/Terraform?logo=github)](https://github.com/HariSekhon/Terraform/commits/master)

[![CI Builds Overview](https://img.shields.io/badge/CI%20Builds-Overview%20Page-blue?logo=circleci)](https://harisekhon.github.io/CI-CD/)
[![Fmt](https://github.com/HariSekhon/Terraform/actions/workflows/terraform-fmt-write.yaml/badge.svg)](https://github.com/HariSekhon/Terraform/actions/workflows/terraform-fmt-write.yaml)
[![YAML](https://github.com/HariSekhon/Terraform/actions/workflows/yaml.yaml/badge.svg)](https://github.com/HariSekhon/Terraform/actions/workflows/yaml.yaml)
[![ShellCheck](https://github.com/HariSekhon/Terraform/actions/workflows/shellcheck.yaml/badge.svg)](https://github.com/HariSekhon/Terraform/actions/workflows/shellcheck.yaml)
[![Validation](https://github.com/HariSekhon/Terraform/actions/workflows/validate.yaml/badge.svg)](https://github.com/HariSekhon/Terraform/actions/workflows/validate.yaml)
[![tfsec](https://github.com/HariSekhon/Terraform/actions/workflows/tfsec.yaml/badge.svg)](https://github.com/HariSekhon/Terraform/actions/workflows/tfsec.yaml)
[![Checkov](https://github.com/HariSekhon/Terraform/actions/workflows/checkov.yaml/badge.svg)](https://github.com/HariSekhon/Terraform/actions/workflows/checkov.yaml)
[![Grype](https://github.com/HariSekhon/Terraform/actions/workflows/grype.yaml/badge.svg)](https://github.com/HariSekhon/Terraform/actions/workflows/grype.yaml)
[![Kics](https://github.com/HariSekhon/Terraform/actions/workflows/kics.yaml/badge.svg)](https://github.com/HariSekhon/Terraform/actions/workflows/kics.yaml)
[![Semgrep](https://github.com/HariSekhon/Terraform/actions/workflows/semgrep.yaml/badge.svg)](https://github.com/HariSekhon/Terraform/actions/workflows/semgrep.yaml)
[![Semgrep Cloud](https://github.com/HariSekhon/Terraform/actions/workflows/semgrep-cloud.yaml/badge.svg)](https://github.com/HariSekhon/Terraform/actions/workflows/semgrep-cloud.yaml)
[![Trivy](https://github.com/HariSekhon/Terraform/actions/workflows/trivy.yaml/badge.svg)](https://github.com/HariSekhon/Terraform/actions/workflows/trivy.yaml)

[![Repo on Azure DevOps](https://img.shields.io/badge/repo-Azure%20DevOps-0078D7?logo=azure%20devops)](https://dev.azure.com/harisekhon/GitHub/_git/Terraform)
[![Repo on GitHub](https://img.shields.io/badge/repo-GitHub-2088FF?logo=github)](https://github.com/HariSekhon/Terraform)
[![Repo on GitLab](https://img.shields.io/badge/repo-GitLab-FCA121?logo=gitlab)](https://gitlab.com/HariSekhon/Terraform)
[![Repo on BitBucket](https://img.shields.io/badge/repo-BitBucket-0052CC?logo=bitbucket)](https://bitbucket.org/HariSekhon/Terraform)

[git.io/tf-templates](https://git.io/tf-templates)

Terraform templates for AWS / GCP / Azure.

Forked from the [Templates](https://github.com/HariSekhon/Templates) repo for which this is now a submodule.


### New

`new.pl` can instantiate these templates as new date-timestamped files, autopopulating the date, vim tags, GitHub URL and other headers and drops you in to your `$EDITOR` of choice (eg. `vim`).

You can give an exact filename like `provider.tf` or `backend.tf` to instantiate that exact template, or any filename ending in `.tfvars` will instantitate some common terraform variables such as `project`, `region`, `vpc_name` etc...  otherwise any filename ending in `tf` will give you a blank terraform template.

Examples:

```bash
new provider.tf
```

```bash
new backend.tf
```

`new.pl` can be found in the [DevOps Perl tools](https://github.com/HariSekhon/DevOps-Perl-tools) repo.

`alias new=new.pl`

(done automatically in the [DevOps Bash tools](https://github.com/HariSekhon/DevOps-Bash-tools) repo `.bash.d/`)


#### New Terraform Structure

```bash
new terraform
```
or shorter
```bash
new tf
```

Instantly creates and opens all standard files for a Terraform deployment in your `$EDITOR` of choice:

- [provider.tf](https://github.com/HariSekhon/Terraform/blob/master/provider.tf)
- [backend.tf](https://github.com/HariSekhon/Terraform/blob/master/backend.tf)
- [variables.tf](https://github.com/HariSekhon/Terraform/blob/master/variables.tf)
- [versions.tf](https://github.com/HariSekhon/Terraform/blob/master/versions.tf)
- [terraform.tfvars](https://github.com/HariSekhon/Terraform/blob/master/terraform.tfvars)
- [main.tf](https://github.com/HariSekhon/Terraform/blob/master/main.tf)

all heavily commented to get a new Terraform environment up and running quickly - with links to things like AWS / GCP regions, Terraform backend providers, state locking etc.

## Troubleshooting

#### DeleteConflict: Recreating Resources with Dependencies That Do Not Permit Deletion

Example:
`│Error: error deleting IAM policy arn:aws:iam::***:policy/MYPOLICY: DeleteConflict: Cannot delete a policy attached to entities.`

The Terraform AWS Provider does not help you when you recreate a resource that another resources depends on, such as recreating an IAM policy due to a rename, while it is still attached to a role, or recreating an AWS Batch compute environment while it's still attached to queues.

Unfortunately the Terraform AWS Provider isn't smart enough to know that for such dependencies with AWS specific API constraints that it should simply detach, and then reattach afterwards.

The quickest solution / workaround is to find the dependent resources, and `terraform taint` them so that they are destroyed first using the generic implicit Terraform dependency ordering, eg. the role gets deleted first for recreation because its tainted, then the IAM policy is deleted and recreated with the new name, and then the role is recreated and attached to the new policy.

Example:

`terraform taint <full_path_of_resource_in_terraform_state>`

## Terraform CI/CD

Production-grade Terraform CI/CD pipelines can be found for Jenkins and GitHub Actions in my adjacent repos:

- [Jenkins](https://github.com/HariSekhon/Jenkins) - runs terraform code with a specific version of Terraform:
  - `fmt` (info only)
  - `validate`
  - `plan` (saves plan so apply is this exact plan, recommended)
  - prompts for plan approval
  - runs `apply`
  - has full locking and milestones for Plan and Apply stages for serialized queuing to avoid terraform state lock failures
  - skips intermediate queued runs for efficiency

- [GitHub Actions](https://github.com/HariSekhon/GitHub-Actions) - similar to above, plus:
  - optional environment / approvals (protects admin credentials for things like GitHub which doesn't have read-only repo API tokens)
  - posts the full `terraform plan` result into the Pull Request that triggered the workflow, along with the status of `fmt` & `validate`
  - applies once Pull Request is merged to the default branch or master or main

### Jenkins screenshots

Applied, ignoring informational fmt check:

![](https://github.com/HariSekhon/Diagrams-as-Code/blob/master/screenshots/terraform_applied_but_failed_fmt_check.png)

Plan found no changes so skipped Apply or asking for Approval:

![](https://github.com/HariSekhon/Diagrams-as-Code/blob/master/screenshots/terraform_plan_no_changes.png)

Plan found changes but Approval was not authorized, so Apply did not proceed:

![](https://github.com/HariSekhon/Diagrams-as-Code/blob/master/screenshots/terraform_not_approved.png)


## Related Repositories

- [Kubernetes configs](https://github.com/HariSekhon/Kubernetes-configs) - Kubernetes YAML configs - Best Practices, Tips & Tricks are baked right into the templates for future deployments

- [Jenkins](https://github.com/HariSekhon/Jenkins) - Advanced Jenkinsfile & Jenkins Groovy Shared Library

- [GitHub-Actions](https://github.com/HariSekhon/GitHub-Actions) - GitHub Actions master template & GitHub Actions Shared Workflows library

- [Templates](https://github.com/HariSekhon/Templates) - dozens of Code & Config templates - AWS, GCP, Docker, Jenkins, Vagrant, Puppet, Python, Bash, Go, Perl, Java, Scala, Groovy, Maven, SBT, Gradle, Make, GitHub Actions Workflows, CircleCI, Jenkinsfile, Makefile, Dockerfile, docker-compose.yml, M4 etc.

- [DevOps Bash Tools](https://github.com/HariSekhon/DevOps-Bash-tools) - 1000+ DevOps Bash Scripts, Advanced `.bashrc`, `.vimrc`, `.screenrc`, `.tmux.conf`, `.gitconfig`, CI configs & Utility Code Library - AWS, GCP, Kubernetes, Docker, Kafka, Hadoop, SQL, BigQuery, Hive, Impala, PostgreSQL, MySQL, LDAP, DockerHub, Jenkins, Spotify API & MP3 tools, Git tricks, GitHub API, GitLab API, BitBucket API, Code & build linting, package management for Linux / Mac / Python / Perl / Ruby / NodeJS / Golang, and lots more random goodies

- [SQL Scripts](https://github.com/HariSekhon/SQL-scripts) - 100+ SQL Scripts - PostgreSQL, MySQL, AWS Athena, Google BigQuery

- [DevOps Python Tools](https://github.com/HariSekhon/DevOps-Python-tools) - 80+ DevOps CLI tools for AWS, GCP, Hadoop, HBase, Spark, Log Anonymizer, Ambari Blueprints, AWS CloudFormation, Linux, Docker, Spark Data Converters & Validators (Avro / Parquet / JSON / CSV / INI / XML / YAML), Elasticsearch, Solr, Travis CI, Pig, IPython

- [DevOps Perl Tools](https://github.com/harisekhon/perl-tools) - 25+ DevOps CLI tools for Hadoop, HDFS, Hive, Solr/SolrCloud CLI, Log Anonymizer, Nginx stats & HTTP(S) URL watchers for load balanced web farms, Dockerfiles & SQL ReCaser (MySQL, PostgreSQL, AWS Redshift, Snowflake, Apache Drill, Hive, Impala, Cassandra CQL, Microsoft SQL Server, Oracle, Couchbase N1QL, Dockerfiles, Pig Latin, Neo4j, InfluxDB), Ambari FreeIPA Kerberos, Datameer, Linux...

- [The Advanced Nagios Plugins Collection](https://github.com/HariSekhon/Nagios-Plugins) - 450+ programs for Nagios monitoring your Hadoop & NoSQL clusters. Covers every Hadoop vendor's management API and every major NoSQL technology (HBase, Cassandra, MongoDB, Elasticsearch, Solr, Riak, Redis etc.) as well as message queues (Kafka, RabbitMQ), continuous integration (Jenkins, Travis CI) and traditional infrastructure (SSL, Whois, DNS, Linux)

- [Nagios Plugin Kafka](https://github.com/HariSekhon/Nagios-Plugin-Kafka) - Kafka API pub/sub Nagios Plugin written in Scala with Kerberos support

- [HAProxy Configs](https://github.com/HariSekhon/HAProxy-configs) - 80+ HAProxy Configs for Hadoop, Big Data, NoSQL, Docker, Elasticsearch, SolrCloud, HBase, Cloudera, Hortonworks, MapR, MySQL, PostgreSQL, Apache Drill, Hive, Presto, Impala, ZooKeeper, OpenTSDB, InfluxDB, Prometheus, Kibana, Graphite, SSH, RabbitMQ, Redis, Riak, Rancher etc.

- [Dockerfiles](https://github.com/HariSekhon/Dockerfiles) - 50+ DockerHub public images for Docker & Kubernetes - Hadoop, Kafka, ZooKeeper, HBase, Cassandra, Solr, SolrCloud, Presto, Apache Drill, Nifi, Spark, Mesos, Consul, Riak, OpenTSDB, Jython, Advanced Nagios Plugins & DevOps Tools repos on Alpine, CentOS, Debian, Fedora, Ubuntu, Superset, H2O, Serf, Alluxio / Tachyon, FakeS3

- [HashiCorp Packer templates](https://github.com/HariSekhon/Packer-templates) - Linux automated bare-metal installs and portable virtual machines OVA format appliances using HashiCorp Packer, Redhat Kickstart, Debian Preseed and Ubuntu AutoInstaller / Cloud-Init

- [Diagrams-as-Code](https://github.com/HariSekhon/Diagrams-as-Code) - Cloud & Open Source architecture diagrams with Python & D2 source code provided - automatically regenerated via GitHub Actions CI/CD - AWS, GCP, Kubernetes, Jenkins, ArgoCD, Traefik, Kong API Gateway, Nginx, Redis, PostgreSQL, Kafka, Spark, web farms, event processing...

[![Stargazers over time](https://starchart.cc/HariSekhon/Terraform.svg)](https://starchart.cc/HariSekhon/Terraform)

[git.io/tf-templates](https://git.io/tf-templates)
