{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kubernetes-helm
    yq-go
    argocd
    stern
    skopeo
    kubectl
    ko
    kn
    k9s
    kind
    # vault
    tektoncd-cli
    lakectl
    openshift
    pack
  ];
}
