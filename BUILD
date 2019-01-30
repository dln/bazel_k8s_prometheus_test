package(default_visibility = ["//visibility:public"])

load(":prometheus.bzl", "targets")

[filegroup(
    name=t,
    srcs = ["manifests/%s.yaml" % t],
) for t in targets]

