# https://github.com/FrameworkComputer/linux-docs/blob/main/easy-effects/README.md
{ pkgs, ... }:
let
  fwDocs = "https://raw.githubusercontent.com/FrameworkComputer/linux-docs/e5289ecc283e0e940536ce48e0ed789adf0280be/easy-effects";
in
{
  services.easyeffects = {
    enable = true;
    preset = "fw13-easy-effects";
  };

  # Presets live in ~/.config/easyeffects/output; the convolver impulse
  # response is referenced by bare name and must sit in ~/.config/easyeffects/irs.
  xdg.configFile = {
    "easyeffects/output/fw13-easy-effects.json".source = pkgs.fetchurl {
      url = "${fwDocs}/fw13-easy-effects.json";
      hash = "sha256-SNSUu858z6+RdcRH9xgBTJeSDJmLu2RINx+OUaWGH3A=";
    };
    "easyeffects/irs/IR_22ms_27dB_5t_15s_0c.irs".source = pkgs.fetchurl {
      url = "${fwDocs}/irs/IR_22ms_27dB_5t_15s_0c.irs";
      hash = "sha256-IxDXNhnTg/NrhPxA5+6u/meEnlX720eoQPyoJfbuge0=";
    };
  };
}
