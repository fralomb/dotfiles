# Cloud Shape Library Reference

Complete catalog of shapes for AWS, GCP, and Kubernetes diagrams in Draw.io.

## AWS (mxgraph.aws4)

### Compute Services

| Service | Shape | Style String |
|---------|-------|-------------|
| EC2 | `shape=mxgraph.aws4.ec2;` | Standard instance icon |
| Lambda | `shape=mxgraph.aws4.lambda_function;` | Serverless function |
| ECS | `shape=mxgraph.aws4.ecs;` | Container service |
| EKS | `shape=mxgraph.aws4.eks_cloud;` | Kubernetes service |
| Batch | `shape=mxgraph.aws4.batch;` | Batch computing |
| Elastic Beanstalk | `shape=mxgraph.aws4.elastic_beanstalk;` | PaaS |
| Lightsail | `shape=mxgraph.aws4.lightsail;` | Simple VPS |
| App Runner | `shape=mxgraph.aws4.app_runner;` | Container apps |

### Storage Services

| Service | Shape | Style String |
|---------|-------|-------------|
| S3 | `shape=mxgraph.aws4.s3;` | Object storage |
| EBS | `shape=mxgraph.aws4.ebs;` | Block storage |
| EFS | `shape=mxgraph.aws4.efs;` | File storage |
| FSx | `shape=mxgraph.aws4.fsx;` | File systems |
| Glacier | `shape=mxgraph.aws4.glacier;` | Archive storage |
| Storage Gateway | `shape=mxgraph.aws4.storage_gateway;` | Hybrid storage |
| Backup | `shape=mxgraph.aws4.backup;` | Backup service |

### Database Services

| Service | Shape | Style String |
|---------|-------|-------------|
| RDS | `shape=mxgraph.aws4.rds;` | Relational database |
| Aurora | `shape=mxgraph.aws4.aurora;` | Cloud-native RDS |
| DynamoDB | `shape=mxgraph.aws4.dynamodb;` | NoSQL database |
| ElastiCache | `shape=mxgraph.aws4.elasticache;` | In-memory cache |
| Neptune | `shape=mxgraph.aws4.neptune;` | Graph database |
| Redshift | `shape=mxgraph.aws4.redshift;` | Data warehouse |
| DocumentDB | `shape=mxgraph.aws4.documentdb;` | MongoDB-compatible |
| Timestream | `shape=mxgraph.aws4.timestream;` | Time series DB |

### Networking

| Service | Shape | Style String |
|---------|-------|-------------|
| VPC | `shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_vpc2;` | Virtual network |
| CloudFront | `shape=mxgraph.aws4.cloudfront;` | CDN |
| Route 53 | `shape=mxgraph.aws4.route_53;` | DNS service |
| API Gateway | `shape=mxgraph.aws4.api_gateway;` | API management |
| ELB/ALB | `shape=mxgraph.aws4.elastic_load_balancing;` | Load balancer |
| Direct Connect | `shape=mxgraph.aws4.direct_connect;` | Dedicated network |
| Transit Gateway | `shape=mxgraph.aws4.transit_gateway;` | Network hub |
| VPN | `shape=mxgraph.aws4.vpn_gateway;` | VPN connection |
| NAT Gateway | `shape=mxgraph.aws4.nat_gateway;` | Network address translation |
| Internet Gateway | `shape=mxgraph.aws4.internet_gateway;` | Internet access |
| PrivateLink | `shape=mxgraph.aws4.privatelink;` | Private connectivity |
| Global Accelerator | `shape=mxgraph.aws4.global_accelerator;` | Network acceleration |

### Security & Identity

| Service | Shape | Style String |
|---------|-------|-------------|
| IAM | `shape=mxgraph.aws4.iam;` | Identity management |
| Cognito | `shape=mxgraph.aws4.cognito;` | User authentication |
| Secrets Manager | `shape=mxgraph.aws4.secrets_manager;` | Secret storage |
| KMS | `shape=mxgraph.aws4.key_management_service;` | Key management |
| WAF | `shape=mxgraph.aws4.waf;` | Web firewall |
| Shield | `shape=mxgraph.aws4.shield;` | DDoS protection |
| GuardDuty | `shape=mxgraph.aws4.guardduty;` | Threat detection |
| Security Hub | `shape=mxgraph.aws4.security_hub;` | Security center |
| Certificate Manager | `shape=mxgraph.aws4.certificate_manager;` | SSL/TLS certs |

### Monitoring & Management

| Service | Shape | Style String |
|---------|-------|-------------|
| CloudWatch | `shape=mxgraph.aws4.cloudwatch;` | Monitoring |
| CloudTrail | `shape=mxgraph.aws4.cloudtrail;` | Audit logging |
| Config | `shape=mxgraph.aws4.config;` | Configuration tracking |
| Systems Manager | `shape=mxgraph.aws4.systems_manager;` | Operations hub |
| X-Ray | `shape=mxgraph.aws4.xray;` | Application tracing |
| CloudFormation | `shape=mxgraph.aws4.cloudformation;` | IaC |

### Containers

| Shape Type | Style String |
|------------|-------------|
| Availability Zone | `shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_availability_zone;strokeColor=#545B64;fillColor=none;dashed=1;` |
| Security Group | `shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_security_group;strokeColor=#00A4A6;fillColor=none;` |
| Auto Scaling Group | `shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_auto_scaling;strokeColor=#D86613;fillColor=none;` |
| Region | `shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_region;strokeColor=#1B660F;fillColor=none;` |
| AWS Cloud | `shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_aws_cloud_alt;strokeColor=#232F3E;fillColor=none;` |

## GCP (mxgraph.gcp2)

### Compute Services

| Service | Shape | Style String |
|---------|-------|-------------|
| Compute Engine | `shape=mxgraph.gcp2.compute_engine;` | VM instances |
| App Engine | `shape=mxgraph.gcp2.app_engine;` | PaaS |
| Cloud Functions | `shape=mxgraph.gcp2.cloud_functions;` | Serverless |
| Cloud Run | `shape=mxgraph.gcp2.cloud_run;` | Container platform |
| GKE | `shape=mxgraph.gcp2.kubernetes_engine;` | Kubernetes |

### Storage Services

| Service | Shape | Style String |
|---------|-------|-------------|
| Cloud Storage | `shape=mxgraph.gcp2.cloud_storage;` | Object storage |
| Persistent Disk | `shape=mxgraph.gcp2.persistent_disk;` | Block storage |
| Filestore | `shape=mxgraph.gcp2.filestore;` | File storage |

### Database Services

| Service | Shape | Style String |
|---------|-------|-------------|
| Cloud SQL | `shape=mxgraph.gcp2.cloud_sql;` | Managed SQL |
| Cloud Spanner | `shape=mxgraph.gcp2.cloud_spanner;` | Global SQL |
| Firestore | `shape=mxgraph.gcp2.firestore;` | NoSQL database |
| Bigtable | `shape=mxgraph.gcp2.bigtable;` | Wide-column store |
| Memorystore | `shape=mxgraph.gcp2.memorystore;` | In-memory cache |

### Networking

| Service | Shape | Style String |
|---------|-------|-------------|
| VPC | `shape=mxgraph.gcp2.container;prIcon=vpc;strokeColor=#4285F4;` | Virtual network |
| Cloud Load Balancing | `shape=mxgraph.gcp2.load_balancing;` | Load balancer |
| Cloud CDN | `shape=mxgraph.gcp2.cloud_cdn;` | Content delivery |
| Cloud DNS | `shape=mxgraph.gcp2.cloud_dns;` | DNS service |
| Cloud NAT | `shape=mxgraph.gcp2.cloud_nat;` | Network translation |
| Cloud VPN | `shape=mxgraph.gcp2.cloud_vpn;` | VPN gateway |
| Cloud Interconnect | `shape=mxgraph.gcp2.cloud_interconnect;` | Dedicated connect |

### Security & Identity

| Service | Shape | Style String |
|---------|-------|-------------|
| Cloud IAM | `shape=mxgraph.gcp2.cloud_iam;` | Identity management |
| Cloud KMS | `shape=mxgraph.gcp2.cloud_kms;` | Key management |
| Secret Manager | `shape=mxgraph.gcp2.secret_manager;` | Secret storage |
| Cloud Armor | `shape=mxgraph.gcp2.cloud_armor;` | DDoS protection |

### Monitoring & Management

| Service | Shape | Style String |
|---------|-------|-------------|
| Cloud Monitoring | `shape=mxgraph.gcp2.cloud_monitoring;` | Observability |
| Cloud Logging | `shape=mxgraph.gcp2.cloud_logging;` | Log management |
| Cloud Trace | `shape=mxgraph.gcp2.cloud_trace;` | Distributed tracing |
| Cloud Profiler | `shape=mxgraph.gcp2.cloud_profiler;` | Performance profiling |

### Containers

| Shape Type | Style String |
|------------|-------------|
| Project | `shape=mxgraph.gcp2.hexagon;prIcon=project;strokeColor=#4285F4;fillColor=none;` |
| Zone | `shape=mxgraph.gcp2.container;prIcon=zone;strokeColor=#4285F4;fillColor=none;dashed=1;` |

## Kubernetes (mxgraph.kubernetes)

### Workload Resources

| Resource | Shape | Style String |
|----------|-------|-------------|
| Pod | `shape=mxgraph.kubernetes.pod;` | Basic unit |
| Deployment | `shape=mxgraph.kubernetes.deploy;` | Replica management |
| StatefulSet | `shape=mxgraph.kubernetes.sts;` | Stateful apps |
| DaemonSet | `shape=mxgraph.kubernetes.ds;` | Node-wide pods |
| Job | `shape=mxgraph.kubernetes.job;` | Batch tasks |
| CronJob | `shape=mxgraph.kubernetes.cronjob;` | Scheduled jobs |
| ReplicaSet | `shape=mxgraph.kubernetes.rs;` | Pod replicas |

### Network Resources

| Resource | Shape | Style String |
|----------|-------|-------------|
| Service | `shape=mxgraph.kubernetes.svc;` | Network endpoint |
| Ingress | `shape=mxgraph.kubernetes.ing;` | HTTP routing |
| NetworkPolicy | `shape=mxgraph.kubernetes.netpol;` | Traffic rules |
| Endpoint | `shape=mxgraph.kubernetes.ep;` | Service endpoint |

### Configuration Resources

| Resource | Shape | Style String |
|----------|-------|-------------|
| ConfigMap | `shape=mxgraph.kubernetes.cm;` | Configuration data |
| Secret | `shape=mxgraph.kubernetes.secret;` | Sensitive data |

### Storage Resources

| Resource | Shape | Style String |
|----------|-------|-------------|
| Volume | `shape=mxgraph.kubernetes.vol;` | Storage volume |
| PersistentVolume | `shape=mxgraph.kubernetes.pv;` | Persistent storage |
| PersistentVolumeClaim | `shape=mxgraph.kubernetes.pvc;` | Storage request |
| StorageClass | `shape=mxgraph.kubernetes.sc;` | Storage provisioner |

### RBAC Resources

| Resource | Shape | Style String |
|----------|-------|-------------|
| ServiceAccount | `shape=mxgraph.kubernetes.sa;` | Pod identity |
| Role | `shape=mxgraph.kubernetes.role;` | Namespace permissions |
| ClusterRole | `shape=mxgraph.kubernetes.c_role;` | Cluster permissions |

### Containers

| Shape Type | Style String |
|------------|-------------|
| Cluster | `shape=mxgraph.kubernetes.cluster;prIcon=cluster;strokeColor=#326CE5;fillColor=none;dashed=1;` |
| Namespace | `shape=mxgraph.kubernetes.ns;prIcon=ns;strokeColor=#326CE5;fillColor=none;` |
| Node | `shape=mxgraph.kubernetes.node;prIcon=node;strokeColor=#326CE5;fillColor=none;` |

## Color Schemes

### AWS Official Colors
- Primary: `#232F3E` (AWS Dark)
- Orange: `#FF9900` (AWS Orange)
- VPC Green: `#248814`
- Security Group: `#00A4A6`
- Warning: `#D86613`

### GCP Official Colors
- Primary: `#4285F4` (Google Blue)
- Secondary: `#34A853` (Google Green)
- Warning: `#FBBC04` (Google Yellow)
- Error: `#EA4335` (Google Red)

### Kubernetes Official Colors
- Primary: `#326CE5` (Kubernetes Blue)
- Secondary: `#0078D4`

## Edge Styles

### AWS Connectors
```xml
style="edgeStyle=orthogonalEdgeStyle;rounded=1;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#232F3E;strokeWidth=2;"
```

### GCP Connectors
```xml
style="edgeStyle=orthogonalEdgeStyle;rounded=1;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#4285F4;strokeWidth=2;"
```

### Kubernetes Connectors
```xml
style="edgeStyle=orthogonalEdgeStyle;rounded=1;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#326CE5;strokeWidth=2;dashed=1;"
```

### Data Flow (Directional)
```xml
style="edgeStyle=orthogonalEdgeStyle;rounded=1;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#FF9900;strokeWidth=3;endArrow=classic;endFill=1;"
```
