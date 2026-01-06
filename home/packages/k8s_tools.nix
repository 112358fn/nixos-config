{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kubernetes-helm
    yq
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
