FROM registry.svc.ci.openshift.org/openshift/release:golang-1.13 AS builder
WORKDIR /go/src/github.com/openshift/cluster-svcat-controller-manager-operator
COPY . .
RUN make build --warn-undefined-variables

FROM registry.svc.ci.openshift.org/openshift/origin-v4.0:base
COPY --from=builder /go/src/github.com/openshift/cluster-svcat-controller-manager-operator/cluster-svcat-controller-manager-operator /usr/bin/
COPY manifests /manifests
COPY vendor/github.com/openshift/api/operator/v1/0000_50_cluster-svcat-controller-manager-operator_02_config.crd.yaml /manifests
LABEL io.openshift.release.operator true
