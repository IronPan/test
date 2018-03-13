{
  parts(params):: {
    local argo = import "ml-pipeline/ml-pipeline/argo.libsonnet"
    local pipeline = import "ml-pipeline/ml-pipeline/pipeline.libsonnet"

    local name = params.name,
    local namespace = params.namespace,
    all:: argo.parts(namespace).all + minio.parts(namespace).all + pipeline.parts(namespace).all,
  },
}
