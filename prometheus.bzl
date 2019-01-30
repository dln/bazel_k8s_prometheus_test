load("@io_bazel_rules_jsonnet//jsonnet:jsonnet.bzl", "jsonnet_to_json")
load("@io_bazel_rules_k8s//k8s:object.bzl", "k8s_object")
load("@io_bazel_rules_k8s//k8s:objects.bzl", "k8s_objects")

targets = [
    "namespace",  # Must be first to create namespace first
    "alertmanager-configmap",
    "alertmanager-deployment",
    "alertmanager-pvc",
    "alertmanager-serviceaccount",
    "alertmanager-service",
    "kube-state-metrics-clusterrolebinding",
    "kube-state-metrics-clusterrole",
    "kube-state-metrics-deployment",
    "kube-state-metrics-serviceaccount",
    "kube-state-metrics-svc",
    "node-exporter-daemonset",
    "node-exporter-serviceaccount",
    "node-exporter-service",
    "pushgateway-deployment",
    "pushgateway-serviceaccount",
    "pushgateway-service",
    "server-clusterrolebinding",
    "server-clusterrole",
    "server-configmap",
    "server-deployment",
    "server-pvc",
    "server-serviceaccount",
    "server-service",
]


def k8s_prometheus(name="", **kw):
    if not name:
         fail("name must be set")

    [k8s_object(
        name="%s-%s" % (name, t),
        kind="...",
        namespace=None if name == "namespace" else "prometheus",
        template="//infra/k8s/prometheus:%s" % t,
        **kw
      )
      for i,t in enumerate(targets)]

    k8s_objects(
        name=name,
        objects=["%s-%s" % (name, t) for t in targets],
    )

