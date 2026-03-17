# Common Diagram Patterns

Real-world examples of cloud architecture diagrams with complete XML implementations.

## AWS Three-Tier Web Application

Classic AWS architecture with web, application, and database tiers across multiple availability zones.

### Diagram Structure

```
AWS Account
└── VPC (10.0.0.0/16)
    ├── AZ-1 (us-east-1a)
    │   ├── Public Subnet (10.0.1.0/24)
    │   │   ├── ALB (Application Load Balancer)
    │   │   └── NAT Gateway
    │   ├── Private Subnet - App (10.0.2.0/24)
    │   │   └── EC2 Auto Scaling Group
    │   └── Private Subnet - DB (10.0.3.0/24)
    │       └── RDS Primary
    └── AZ-2 (us-east-1b)
        ├── Public Subnet (10.0.4.0/24)
        │   └── NAT Gateway
        ├── Private Subnet - App (10.0.5.0/24)
        │   └── EC2 Auto Scaling Group
        └── Private Subnet - DB (10.0.6.0/24)
            └── RDS Standby
```

### Key Components

1. **Internet Gateway** - Entry point for public traffic
2. **Application Load Balancer** - Distributes traffic across AZs
3. **Auto Scaling Groups** - Manages EC2 fleet
4. **RDS Multi-AZ** - Database with automatic failover
5. **NAT Gateways** - Outbound internet for private subnets

### Style Specifications

- VPC: `shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_vpc2;strokeColor=#248814`
- AZ: `shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_availability_zone;strokeColor=#545B64;dashed=1`
- Public Subnet: `shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_security_group;strokeColor=#00A4A6`
- Private Subnet: `shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_security_group;strokeColor=#147EBA`

## GCP Microservices Architecture

GKE-based microservices with Cloud SQL, Cloud Storage, and Cloud Load Balancing.

### Diagram Structure

```
GCP Project
├── GKE Cluster (us-central1)
│   ├── Namespace: Production
│   │   ├── Frontend Deployment
│   │   ├── API Gateway Deployment
│   │   ├── Auth Service Deployment
│   │   ├── Order Service Deployment
│   │   └── Payment Service Deployment
│   └── Namespace: Monitoring
│       ├── Prometheus
│       └── Grafana
├── Cloud Load Balancing
├── Cloud SQL (PostgreSQL)
├── Cloud Storage
└── Cloud Memorystore (Redis)
```

### Key Components

1. **GKE Cluster** - Managed Kubernetes
2. **Multiple Services** - Microservice deployments
3. **Cloud Load Balancing** - L7 load balancer with SSL
4. **Cloud SQL** - Managed PostgreSQL
5. **Cloud Memorystore** - Managed Redis cache

### Style Specifications

- Project: `shape=mxgraph.gcp2.hexagon;prIcon=project;strokeColor=#4285F4`
- GKE: `shape=mxgraph.gcp2.kubernetes_engine;fillColor=#4285F4`
- Deployments: `shape=mxgraph.kubernetes.deploy;strokeColor=#326CE5`
- Services: `shape=mxgraph.kubernetes.svc;strokeColor=#326CE5`

## Kubernetes Application Stack

Complete Kubernetes application with ingress, services, and persistent storage.

### Diagram Structure

```
Cluster
├── Namespace: web-app
│   ├── Ingress Controller
│   ├── Frontend
│   │   ├── Deployment (3 replicas)
│   │   └── Service (ClusterIP)
│   ├── Backend API
│   │   ├── Deployment (5 replicas)
│   │   ├── Service (ClusterIP)
│   │   ├── ConfigMap (app-config)
│   │   └── Secret (api-keys)
│   └── Database
│       ├── StatefulSet (3 replicas)
│       ├── Service (Headless)
│       ├── PersistentVolumeClaim
│       └── Secret (db-credentials)
└── Namespace: monitoring
    ├── Prometheus StatefulSet
    └── Grafana Deployment
```

### Key Components

1. **Ingress** - External HTTP/HTTPS routing
2. **Deployments** - Stateless applications
3. **StatefulSet** - Stateful database workload
4. **Services** - Internal networking
5. **ConfigMaps/Secrets** - Configuration management
6. **PersistentVolumes** - Durable storage

### Style Specifications

- Namespace: `shape=mxgraph.kubernetes.ns;prIcon=ns;strokeColor=#326CE5`
- Ingress: `shape=mxgraph.kubernetes.ing;fillColor=#326CE5`
- Deployment: `shape=mxgraph.kubernetes.deploy;fillColor=#326CE5`
- Service: `shape=mxgraph.kubernetes.svc;fillColor=#326CE5`

## AWS Serverless Application

Event-driven architecture using Lambda, API Gateway, and DynamoDB.

### Diagram Structure

```
AWS Account
├── CloudFront
├── S3 (Static Website)
├── API Gateway (REST)
├── Lambda Functions
│   ├── User Management
│   ├── Order Processing
│   ├── Payment Processing
│   └── Notification Service
├── DynamoDB
│   ├── Users Table
│   ├── Orders Table
│   └── Transactions Table
├── SQS Queue
├── SNS Topics
└── S3 (File Storage)
```

### Key Components

1. **CloudFront + S3** - Static website hosting
2. **API Gateway** - RESTful API endpoints
3. **Lambda Functions** - Event-driven processing
4. **DynamoDB** - NoSQL database
5. **SQS/SNS** - Async messaging

### Style Specifications

- Lambda: `shape=mxgraph.aws4.lambda_function;fillColor=#FF9900`
- API Gateway: `shape=mxgraph.aws4.api_gateway;fillColor=#FF4F8B`
- DynamoDB: `shape=mxgraph.aws4.dynamodb;fillColor=#4053D6`

## Multi-Cloud Hybrid Architecture

Hybrid setup connecting AWS and GCP with VPN.

### Diagram Structure

```
AWS Account
├── VPC (us-east-1)
│   ├── EC2 Instances
│   ├── RDS
│   └── VPN Gateway
│       └── VPN Tunnel
│
GCP Project
├── VPC Network (us-central1)
│   ├── Compute Engine VMs
│   ├── Cloud SQL
│   └── Cloud VPN Gateway
│       └── VPN Tunnel
│
On-Premises
└── Data Center
    ├── Application Servers
    └── Legacy Database
```

### Key Components

1. **VPN Tunnels** - Encrypted connectivity
2. **Multi-cloud Resources** - AWS and GCP services
3. **Hybrid Integration** - On-premises connectivity
4. **Data Synchronization** - Cross-cloud replication

## Diagram Layout Tips

### Vertical Flow (Top to Bottom)
Best for: Request flow, data pipelines, CI/CD

```
Internet Users
    ↓
Load Balancer
    ↓
Application Tier
    ↓
Database Tier
```

### Horizontal Flow (Left to Right)
Best for: Microservices, event processing, data flow

```
API Gateway → Auth Service → Order Service → Payment Service → Database
```

### Radial Layout (Hub and Spoke)
Best for: Central services, API gateways, service mesh

```
        Service A
            |
    Service B - API Gateway - Service C
            |
        Service D
```

### Grid Layout (Matrix)
Best for: Multi-region, availability zones, compliance boundaries

```
┌────────────┬────────────┐
│   AZ-1     │   AZ-2     │
│ Subnet A   │ Subnet D   │
│ Subnet B   │ Subnet E   │
│ Subnet C   │ Subnet F   │
└────────────┴────────────┘
```

## Common Connector Patterns

### Direct Connection
```xml
<mxCell style="edgeStyle=orthogonalEdgeStyle;rounded=1;html=1;strokeColor=#232F3E;strokeWidth=2;"/>
```
Use for: Direct service-to-service communication

### Data Flow
```xml
<mxCell style="edgeStyle=orthogonalEdgeStyle;rounded=1;html=1;strokeColor=#FF9900;strokeWidth=3;endArrow=classic;"/>
```
Use for: Data movement, ETL pipelines

### Bidirectional
```xml
<mxCell style="edgeStyle=orthogonalEdgeStyle;rounded=1;html=1;strokeColor=#232F3E;strokeWidth=2;startArrow=classic;endArrow=classic;"/>
```
Use for: Two-way communication, sync operations

### Dashed (Optional/Async)
```xml
<mxCell style="edgeStyle=orthogonalEdgeStyle;rounded=1;html=1;strokeColor=#232F3E;strokeWidth=2;dashed=1;"/>
```
Use for: Optional connections, async communication

## Label Best Practices

### Service Labels
- Format: `[Service Name]\n[Instance Type/Size]`
- Example: `Web Server\nm5.large`

### Connection Labels
- Format: `[Protocol/Port] [Traffic Type]`
- Example: `HTTPS:443\nPublic Traffic`

### Container Labels
- Format: `[Container Type] - [Name/CIDR]`
- Example: `VPC - Production\n10.0.0.0/16`

### Annotation Labels
- Format: `[Info Type]: [Details]`
- Example: `Cost: $500/month\nRedundancy: Multi-AZ`

## Color Coding Strategies

### By Environment
- Production: Solid borders, official colors
- Staging: Dashed borders, muted colors
- Development: Dotted borders, light colors

### By Security Zone
- Public: Green `#00A4A6`
- Private: Blue `#147EBA`
- Restricted: Red `#D13212`

### By Data Classification
- Public Data: Light fill
- Internal Data: Medium fill
- Sensitive Data: Dark fill + border

### By Service Tier
- Frontend: Orange `#FF9900`
- Backend: Blue `#232F3E`
- Data: Purple `#4053D6`
