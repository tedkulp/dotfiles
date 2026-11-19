// Key launcher (ported from ~/.config/herdr/config.toml): keys.json opens it
// with mod.open:key-worktree-open, it does one thing and closes itself.
import { View, div } from "gpui-kit";
import { run, props, closeOverlay, openOverlay, panes, spaces } from "herdr";

export default class Launch extends View {
  init(_props, _cx) {
    // Only act when opened from a key (herdr-app check renders it without props).
    const overlay = props()?.overlay;
    if (!overlay) return;
    closeOverlay(overlay);
    openOverlay({ mod: "worktree", kind: "dialog", width: 560, height: 480, props: { space: spaces().find((s) => s.active)?.id, folder: panes().find((p) => p.focused)?.cwd, action: "open" } });
  }

  render(_cx) {
    return div();
  }
}
