---
name: drawio-cloud-architect
description: Professional cloud architecture diagram creation in Draw.io using provider-specific shapes and icons. Use when creating AWS, GCP, or Kubernetes architecture diagrams, network diagrams, infrastructure designs, or any cloud/container-based visual documentation. Automatically applies cloud-native shapes for VPCs, services, accounts, connectors, and workloads.
---

# Draw.io Cloud Architect

## Overview

Create professional cloud architecture diagrams in Draw.io format (.drawio, .xml) using provider-specific shapes from AWS, GCP, and Kubernetes libraries. This skill ensures diagrams follow cloud architecture best practices with proper shape selection, styling, and organization.

## Core Principles

1. **Use Cloud-Specific Shapes**: Always prefer provider-specific shapes over generic shapes
2. **Hierarchical Organization**: Use groups and containers to represent logical boundaries
3. **Consistent Styling**: Apply provider-specific styles and colors
4. **Shape Library Awareness**: Check for and warn about required shape libraries

## Quick Start

When asked to create a cloud architecture diagram:

1. Identify the cloud provider(s) and services involved
2. Select appropriate container shapes (VPC, accounts, regions)
3. Add service-specific icons and shapes
4. Connect components with provider-appropriate connectors
5. Apply proper labels and styling

## Cloud Provider Shape Libraries

### AWS Shapes (mxgraph.aws4)

**Account/Organization Container:**
```xml
<mxCell style="shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_aws_cloud_alt;strokeColor=#232F3E;fillColor=none;verticalAlign=top;align=left;spacingLeft=30;fontColor=#232F3E;dashed=0;"/>
```

**VPC Container:**
```xml
<mxCell style="shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_vpc2;strokeColor=#248814;fillColor=none;verticalAlign=top;align=left;spacingLeft=30;fontColor=#248814;dashed=0;"/>
```

**Availability Zone:**
```xml
<mxCell style="shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_availability_zone;strokeColor=#545B64;fillColor=none;verticalAlign=top;align=left;spacingLeft=30;fontColor=#545B64;dashed=1;"/>
```

**Subnet (Public/Private):**
```xml
<mxCell style="shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_security_group;strokeColor=#00A4A6;fillColor=none;verticalAlign=top;align=left;spacingLeft=30;fontColor=#147EBA;dashed=0;"/>
```

**Service Icons:**
- EC2: `shape=mxgraph.aws4.ec2;`
- Lambda: `shape=mxgraph.aws4.lambda_function;`
- RDS: `shape=mxgraph.aws4.rds;`
- S3: `shape=mxgraph.aws4.s3;`
- EKS: `shape=mxgraph.aws4.eks_cloud;`
- ALB/ELB: `shape=mxgraph.aws4.elastic_load_balancing;`
- Route53: `shape=mxgraph.aws4.route_53;`
- CloudWatch: `shape=mxgraph.aws4.cloudwatch;`
- IAM: `shape=mxgraph.aws4.iam;`

**Connectors:**
Use AWS-specific edge styles with appropriate colors (#232F3E for general connections, #FF9900 for data flow).

### GCP Shapes (mxgraph.gcp2)

**Project Container:**
```xml
<mxCell style="shape=mxgraph.gcp2.hexagon;perimeter=hexagonPerimeter2;prIcon=project;strokeColor=#4285F4;fillColor=none;verticalAlign=top;align=left;spacingLeft=30;fontColor=#4285F4;dashed=0;"/>
```

**VPC Network:**
```xml
<mxCell style="shape=mxgraph.gcp2.container;prIcon=vpc;strokeColor=#4285F4;fillColor=none;verticalAlign=top;align=left;spacingLeft=30;fontColor=#4285F4;dashed=1;"/>
```

**Service Icons:**
- Compute Engine: `shape=mxgraph.gcp2.compute_engine;`
- Cloud Functions: `shape=mxgraph.gcp2.cloud_functions;`
- Cloud SQL: `shape=mxgraph.gcp2.cloud_sql;`
- Cloud Storage: `shape=mxgraph.gcp2.cloud_storage;`
- GKE: `shape=mxgraph.gcp2.kubernetes_engine;`
- Cloud Load Balancing: `shape=mxgraph.gcp2.load_balancing;`
- Cloud DNS: `shape=mxgraph.gcp2.cloud_dns;`
- Cloud Spanner: `shape=mxgraph.gcp2.cloud_spanner;`

**Connectors:**
Use GCP-specific edge styles with #4285F4 (Google Blue) for primary connections.

### Kubernetes Shapes (mxgraph.kubernetes)

**Cluster:**
```xml
<mxCell style="shape=mxgraph.kubernetes.cluster;prIcon=cluster;strokeColor=#326CE5;fillColor=none;verticalAlign=top;align=left;spacingLeft=30;fontColor=#326CE5;dashed=1;"/>
```

**Namespace:**
```xml
<mxCell style="shape=mxgraph.kubernetes.ns;prIcon=ns;strokeColor=#326CE5;fillColor=none;verticalAlign=top;align=left;spacingLeft=30;fontColor=#326CE5;dashed=0;"/>
```

**Resources:**
- Pod: `shape=mxgraph.kubernetes.pod;`
- Deployment: `shape=mxgraph.kubernetes.deploy;`
- Service: `shape=mxgraph.kubernetes.svc;`
- Ingress: `shape=mxgraph.kubernetes.ing;`
- ConfigMap: `shape=mxgraph.kubernetes.cm;`
- Secret: `shape=mxgraph.kubernetes.secret;`
- PersistentVolume: `shape=mxgraph.kubernetes.pv;`
- StatefulSet: `shape=mxgraph.kubernetes.sts;`
- DaemonSet: `shape=mxgraph.kubernetes.ds;`

## Diagram Structure

### XML Format

Draw.io files use XML with mxGraph format. Structure:

```xml
<mxfile host="app.diagrams.net">
  <diagram name="Architecture">
    <mxGraphModel dx="1422" dy="794" grid="1" gridSize="10" guides="1">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />
        <!-- Cells go here -->
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
```

### Cell Structure

**Container/Group:**
```xml
<mxCell id="unique-id-1" value="VPC Name" style="shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_vpc2;..." vertex="1" parent="1">
  <mxGeometry x="100" y="100" width="600" height="400" as="geometry"/>
</mxCell>
```

**Service Icon:**
```xml
<mxCell id="unique-id-2" value="EC2 Instance" style="shape=mxgraph.aws4.ec2;..." vertex="1" parent="unique-id-1">
  <mxGeometry x="50" y="50" width="78" height="78" as="geometry"/>
</mxCell>
```

**Connector:**
```xml
<mxCell id="unique-id-3" value="Traffic Flow" style="edgeStyle=orthogonalEdgeStyle;..." edge="1" source="unique-id-2" target="unique-id-4" parent="1">
  <mxGeometry relative="1" as="geometry"/>
</mxCell>
```

## Shape Library Warning System

Before creating diagrams, check if the required shape library is available. If shapes from `mxgraph.aws4`, `mxgraph.gcp2`, or `mxgraph.kubernetes` are needed, include this warning:

```
⚠️ SHAPE LIBRARY REQUIREMENT:
This diagram uses [AWS/GCP/Kubernetes] shapes from the [library-name] library.

To ensure proper rendering:
1. Open the diagram in Draw.io
2. Go to File > Open Library from > [Provider]
3. Enable the required shape library
4. Or use the built-in shape search to add shapes

If shapes don't render correctly, the library may need to be enabled in Draw.io preferences.
```

## Common Diagram Patterns

### AWS VPC Architecture

1. Create AWS Account container (outermost)
2. Add VPC container inside account
3. Add Availability Zones inside VPC
4. Add Subnets (public/private) inside AZs
5. Place service icons in appropriate subnets
6. Add Internet Gateway, NAT Gateway as needed
7. Connect with AWS-styled edges

### GCP Multi-Region Setup

1. Create GCP Project container
2. Add multiple Region containers
3. Place VPC Network spanning regions
4. Add service icons (Compute, Storage, etc.)
5. Show inter-region connectivity
6. Use GCP color scheme (#4285F4)

### Kubernetes Workload

1. Create Cluster container
2. Add Namespace containers
3. Place Deployments/StatefulSets
4. Add Services and Ingress
5. Show Pod relationships
6. Include ConfigMaps/Secrets
7. Use Kubernetes blue (#326CE5)

## Best Practices

1. **ID Management**: Use descriptive, unique IDs (e.g., `vpc-main`, `ec2-web-server`)
2. **Parent Hierarchy**: Set parent IDs correctly to show containment
3. **Geometry**: Use consistent sizing (AWS icons typically 78x78, containers multiples of 50)
4. **Grid Alignment**: Align to 10-pixel grid for professional appearance
5. **Labels**: Use clear, descriptive labels for all components
6. **Colors**: Stick to provider color schemes (AWS: #232F3E/Orange, GCP: #4285F4, K8s: #326CE5)
7. **Edge Styles**: Use orthogonal edges for clarity (`edgeStyle=orthogonalEdgeStyle`)
8. **Documentation**: Add notes or text boxes for important details

## Advanced Features

### Multi-Cloud Diagrams

When showing multi-cloud or hybrid architectures:
1. Use separate containers for each provider
2. Show interconnections clearly (VPN, Direct Connect, etc.)
3. Use neutral colors for shared components
4. Label provider boundaries explicitly

### Network Flow

Show data flow with:
1. Directional arrows
2. Edge labels indicating protocol/port
3. Different line styles (solid, dashed) for different connection types
4. Color coding for traffic types

### Security Boundaries

Represent security zones:
1. Use dashed lines for security group boundaries
2. Different colors for DMZ, internal, management zones
3. Firewall/WAF icons at boundaries
4. IAM roles and policies near resources

## Resources

### references/

For detailed shape libraries and advanced patterns, see:
- `references/shape-library.md` - Complete catalog of AWS, GCP, Kubernetes shapes
- `references/examples.md` - Common diagram templates and patterns

These references contain exhaustive shape lists and are loaded only when detailed shape information is needed.
