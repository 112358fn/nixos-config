---
description: 15-minute teach-back on something I used without understanding
allowed-tools: Bash(zk list:*)
---

Topic: $ARGUMENTS

If I passed a topic, first create a note for it with
`zk new --print-path --template dig.md --title "<topic>"` and use
the printed path as the note from here on.

If no topic is given, list the pile with
`zk list --quiet --no-pager --tag dig --sort created --format '{{abs-path}}  {{title}}'`
and ask me which entry I want.

Run this as a teach-back, not a lecture:

1. First ask me to explain what I currently think is going on. Wait.
2. Do not correct me wholesale. Ask questions that expose the gaps in
   my explanation, one at a time, and let me try to close them.
3. Answer factual questions fully and directly when I ask them.
4. When my model holds up, ask me to explain it back as if teaching it.
   Point out anything still vague.
5. Then finish by editing the note: first update the date in frontmatter;
   then append my own summary, in my words from step 4, as a new paragraph
   at the end of the note, leaving existing content unchanged; then in
   the frontmatter replace the `dig` tag with `til`. End your last message
   with the note's absolute path on its own line.
