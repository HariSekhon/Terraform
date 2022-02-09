Terraform Templates
====================

[![Validation](https://github.com/HariSekhon/Terraform/actions/workflows/validate.yaml/badge.svg)](https://github.com/HariSekhon/Terraform/actions/workflows/validate.yaml)
[![tfsec](https://github.com/HariSekhon/Terraform/actions/workflows/tfsec.yaml/badge.svg)](https://github.com/HariSekhon/Terraform/actions/workflows/tfsec.yaml)
[![Semgrep](https://github.com/HariSekhon/Terraform/actions/workflows/semgrep.yaml/badge.svg)](https://github.com/HariSekhon/Terraform/actions/workflows/semgrep.yaml)
[![Checkov](https://github.com/HariSekhon/Terraform/actions/workflows/checkov.yaml/badge.svg)](https://github.com/HariSekhon/Terraform/actions/workflows/checkov.yaml)
[![CI Builds Overview](https://img.shields.io/badge/CI%20Builds-Overview%20Page-blue?logo=circleci)](https://bitbucket.org/harisekhon/devops-bash-tools/src/master/STATUS.md)
[![Travis CI](https://img.shields.io/badge/TravisCI-legacy-lightgrey?logo=travis&label=Travis%20CI)](https://github.com/HariSekhon/Terraform/blob/master/.travis.yml)

[![Repo on Azure DevOps](https://img.shields.io/badge/repo-Azure%20DevOps-0078D7?logo=azure%20devops)](https://dev.azure.com/harisekhon/GitHub/_git/Terraform)
[![Repo on GitHub](https://img.shields.io/badge/repo-GitHub-2088FF?logo=github)](https://github.com/HariSekhon/Terraform)
[![Repo on GitLab](https://img.shields.io/badge/repo-GitLab-FCA121?logo=gitlab)](https://gitlab.com/HariSekhon/Terraform)
[![Repo on BitBucket](https://img.shields.io/badge/repo-BitBucket-0052CC?logo=bitbucket)](https://bitbucket.org/HariSekhon/Terraform)

[![GitHub Last Commit](https://img.shields.io/github/last-commit/HariSekhon/Terraform?logo=github)](https://github.com/HariSekhon/Terraform/commits/master)
[![Lines of Config](https://img.shields.io/badge/lines%20of%20config-2k-lightgrey?logo=codecademy)](https://github.com/HariSekhon/Terraform)
[![GitHub stars](https://img.shields.io/github/stars/HariSekhon/Terraform?logo=github)](https://github.com/HariSekhon/Terraform//stargazers)
[![GitHub forks](https://img.shields.io/github/forks/HariSekhon/Terraform?logo=github)](https://github.com/HariSekhon/Terraform/network)
[![License](https://img.shields.io/github/license/HariSekhon/Terraform)](https://github.com/HariSekhon/Terraform/blob/master/LICENSE)

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


### See Also

- [Kubernetes configs](https://github.com/HariSekhon/Kubernetes-configs) - Kubernetes YAML configs - Best Practices, Tips & Tricks are baked right into the templates for future deployments

- [Templates](https://github.com/HariSekhon/Templates) - dozens of Code & Config templates - AWS, GCP, Docker, Jenkins, Vagrant, Puppet, Python, Bash, Go, Perl, Java, Scala, Groovy, Maven, SBT, Gradle, Make, GitHub Actions Workflows, CircleCI, Jenkinsfile, Makefile, Dockerfile, docker-compose.yml, M4 etc.

- [DevOps Bash Tools](https://github.com/harisekhon/devops-bash-tools) - 700+ DevOps Bash Scripts, Advanced `.bashrc`, `.vimrc`, `.screenrc`, `.tmux.conf`, `.gitconfig`, CI configs & Utility Code Library - AWS, GCP, Kubernetes, Docker, Kafka, Hadoop, SQL, BigQuery, Hive, Impala, PostgreSQL, MySQL, LDAP, DockerHub, Jenkins, Spotify API & MP3 tools, Git tricks, GitHub API, GitLab API, BitBucket API, Code & build linting, package management for Linux / Mac / Python / Perl / Ruby / NodeJS / Golang, and lots more random goodies

- [SQL Scripts](https://github.com/HariSekhon/SQL-scripts) - 100+ SQL Scripts - PostgreSQL, MySQL, AWS Athena, Google BigQuery

- [DevOps Python Tools](https://github.com/harisekhon/devops-python-tools) - 80+ DevOps CLI tools for AWS, GCP, Hadoop, HBase, Spark, Log Anonymizer, Ambari Blueprints, AWS CloudFormation, Linux, Docker, Spark Data Converters & Validators (Avro / Parquet / JSON / CSV / INI / XML / YAML), Elasticsearch, Solr, Travis CI, Pig, IPython

- [DevOps Perl Tools](https://github.com/harisekhon/perl-tools) - 25+ DevOps CLI tools for Hadoop, HDFS, Hive, Solr/SolrCloud CLI, Log Anonymizer, Nginx stats & HTTP(S) URL watchers for load balanced web farms, Dockerfiles & SQL ReCaser (MySQL, PostgreSQL, AWS Redshift, Snowflake, Apache Drill, Hive, Impala, Cassandra CQL, Microsoft SQL Server, Oracle, Couchbase N1QL, Dockerfiles, Pig Latin, Neo4j, InfluxDB), Ambari FreeIPA Kerberos, Datameer, Linux...

- [The Advanced Nagios Plugins Collection](https://github.com/harisekhon/nagios-plugins) - 450+ programs for Nagios monitoring your Hadoop & NoSQL clusters. Covers every Hadoop vendor's management API and every major NoSQL technology (HBase, Cassandra, MongoDB, Elasticsearch, Solr, Riak, Redis etc.) as well as message queues (Kafka, RabbitMQ), continuous integration (Jenkins, Travis CI) and traditional infrastructure (SSL, Whois, DNS, Linux)

- [HAProxy Configs](https://github.com/HariSekhon/HAProxy-configs) - 80+ HAProxy Configs for Hadoop, Big Data, NoSQL, Docker, Elasticsearch, SolrCloud, HBase, Cloudera, Hortonworks, MapR, MySQL, PostgreSQL, Apache Drill, Hive, Presto, Impala, ZooKeeper, OpenTSDB, InfluxDB, Prometheus, Kibana, Graphite, SSH, RabbitMQ, Redis, Riak, Rancher etc.

- [Dockerfiles](https://github.com/HariSekhon/Dockerfiles) - 50+ DockerHub public images for Docker & Kubernetes - Hadoop, Kafka, ZooKeeper, HBase, Cassandra, Solr, SolrCloud, Presto, Apache Drill, Nifi, Spark, Mesos, Consul, Riak, OpenTSDB, Jython, Advanced Nagios Plugins & DevOps Tools repos on Alpine, CentOS, Debian, Fedora, Ubuntu, Superset, H2O, Serf, Alluxio / Tachyon, FakeS3

[![Stargazers over time](https://starchart.cc/HariSekhon/Terraform.svg)](https://starchart.cc/HariSekhon/Terraform)

[git.io/tf-templates](https://git.io/tf-templates)
