{
  parts(params):: {
    local argo = import "k8s/ml-pipeline/argo.libsonnet"
    local pipeline = import "k8s/ml-pipeline/pipeline.libsonnet"

    local name = params.name,
    local namespace = params.namespace,
    all:: argo.parts(namespace).all + minio.parts(namespace).all + pipeline.parts(namespace).all,
  },
}