// @apiVersion 0.1
// @name io.ksonnet.pkg.ml-pipeline
// @description ML pipeline. Currently includes pipeline API server, frontend and dependencies.
// @shortDescription ML pipeline
// @param name string Name to give to each of the components
// @optionalParam namespace string default Namespace

local k = import "k.libsonnet";
local all = import "ml-pipeline/all.libsonnet";

std.prune(k.core.v1.list.new(all.parts(params).all))
