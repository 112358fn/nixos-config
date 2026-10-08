{ config, ... }:
{
  home.sessionVariables.ZK_NOTEBOOK_DIR = "$HOME/Documents/notes";

  # Flat notebook rooted at ~/Documents/notes. What used to be inbox/,
  # projects/, resources/ and til/ directories is now a tag on the note itself;
  # retrieval is by tag, not by path.
  programs.zk = {
    enable = true;
    settings = {
      note = {
        # Filenames are a random 4-character ID, not the title. The ID is a
        # stable handle: retitling a note is a frontmatter edit, with no rename
        # and no link rewrite across the vault. Human-readable context lives in
        # the title and in the `[[id|Title]]` alias on each link.
        filename = "{{id}}";
        id-charset = "alphanum";
        id-length = 4;
        id-case = "lower";

        # Relative to the templates dir (~/.config/zk/templates, below).
        template = "default.md";

        # Exclude globs don't cross directory boundaries: a bare `foo` would not
        # match `foo/sub/x.md`, it needs `foo/**`.
        exclude = [ ];
      };

      format.markdown = {
        hashtags = true;
        colon-tags = false;
        multiword-tags = false;
      };

      lsp.diagnostics.dead-link = "error";

      # Replaces zk's default fzf flags rather than extending them, so the
      # defaults are restated here. `--multi` lets Tab mark several notes.
      tool.fzf-options = "--multi --height 100% --layout reverse --tiebreak begin --exact --no-hscroll --color hl:-1,hl+:-1 --preview-window wrap";

      # Aliases are run by zk through $SHELL, which is fish -- so forwarding
      # extra arguments is `$argv`, not the POSIX `$@`. Under sh/bash `$argv`
      # expands to nothing, so these silently drop their arguments if ever run
      # with SHELL=sh. zk prepends `cd "<notebook root>" &&` to every alias.
      alias = {
        dig = "zk new --print-path --template dig.md --title \"$argv\"";
        recent = "zk edit --sort modified- --interactive $argv";
        proj = "zk edit --interactive --tag projects $argv";
        res = "zk edit --interactive --tag resources $argv";
        til = "zk edit --interactive --tag til $argv";
        # Triage the capture inbox: notes tagged `inbox`, oldest first.
        inbox = "zk edit --sort created --interactive --tag inbox $argv";
        gotcha = "zk edit --interactive --tag gotcha $argv";
        # Pick notes in fzf and print their absolute paths, NUL-separated, for
        # piping into `xargs -0`. Quoted so fish leaves the braces alone.
        pick = "zk list -iqP --format '{{abs-path}}' --delimiter0 $argv";
        conf = "$EDITOR ${config.xdg.configHome}/home-manager/home/alvaro/modules/notes.nix";
      };
    };
  };

  xdg.configFile."zk/templates/default.md".text = ''
    ---
    title: {{title}}
    date: {{format-date now "%Y-%m-%d"}}
    tags: []
    ---

    {{content}}
  '';

  xdg.configFile."zk/templates/dig.md".text = ''
    ---
    title: {{title}}
    date: {{format-date now "%Y-%m-%d"}}
    tags: [dig]
    ---

    {{content}}
  '';
}
