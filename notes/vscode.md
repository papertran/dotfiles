Since you are using **Neovim** inside VS Code, your `<Leader>` key is set to **Space**.

### 📂 File & Project Management

| Keybinding        | Action               | VS Code Command                            |
| :---------------- | :------------------- | :----------------------------------------- |
| **Space** `f` `f` | Quick Open Files     | `workbench.action.quickOpen`               |
| **Space** `f` `g` | Global Search / Grep | `workbench.action.findInFiles`             |
| **Space** `p` `s` | Open Recent Projects | `workbench.action.openRecent`              |
| **Space** `e`     | Toggle File Explorer | `workbench.action.toggleSidebarVisibility` |
| **Space** `=`     | Format Document      | `editor.action.formatDocument`             |

### 🪟 Window & Editor Management

| Keybinding                       | Action                                | VS Code Command                                |
| :------------------------------- | :------------------------------------ | :--------------------------------------------- |
| **Ctrl** + `h` / `j` / `k` / `l` | **Navigate** Left / Down / Up / Right | `workbench.action.navigate...`                 |
| **Space** `w` `v`                | Split Vertical                        | `workbench.action.splitEditor`                 |
| **Space** `w` `s`                | Split Horizontal                      | `workbench.action.splitEditorDown`             |
| **Space** `w` `q`                | Close Active Editor                   | `workbench.action.closeActiveEditor`           |
| **Alt** + `↑` / `↓`              | Resize Height                         | `workbench.action.increase/decreaseViewHeight` |
| **Alt** + `←` / `→`              | Resize Width                          | `workbench.action.increase/decreaseViewWidth`  |

### 🧠 Code Navigation & Refactoring

| Keybinding | Action                      | VS Code Command                             |
| :--------- | :-------------------------- | :------------------------------------------ |
| `g` `r`    | Rename Symbol               | `editor.action.rename`                      |
| `g` `d`    | Go to Definition            | `editor.action.revealDefinition`            |
| `g` `D`    | Peek Definition             | `editor.action.peekDefinition`              |
| `g` `b`    | Add Selection to Next Match | `editor.action.addSelectionToNextFindMatch` |
| `s`        | **Flash Jump**              | Jump to any character on screen             |

### 🌲 Git Integration

| Keybinding        | Action           | Notes                                          |
| :---------------- | :--------------- | :--------------------------------------------- |
| **Space** `g` `g` | Open **Lazygit** | Runs the terminal task defined in `tasks.json` |

### 💻 Terminal Control

| Keybinding          | Action                  | Condition             |
| :------------------ | :---------------------- | :-------------------- |
| **Ctrl** + \`       | Toggle Terminal Panel   | Always active         |
| **Alt** + `j`       | Focus Next Terminal     | When terminal focused |
| **Alt** + `k`       | Focus Previous Terminal | When terminal focused |
| **Alt** + `h` / `l` | Focus Split Panes       | When terminal focused |
| **Alt** + `w`       | Kill (Close) Terminal   | When terminal focused |

### 🐞 Debugging

| Keybinding          | Action            |
| :------------------ | :---------------- |
| **F5**              | Start / Continue  |
| **Shift** + **F5**  | Stop              |
| **F9**              | Toggle Breakpoint |
| **F10**             | Step Over         |
| **F11**             | Step Into         |
| **Shift** + **F11** | Step Out          |

---

### ⚡ Vim Plugin Reference (Implicit Bindings)

Since you installed `mini.surround` and `mini.ai`, you have these powerful implicit bindings available in Normal/Visual mode:

#### **Mini.Surround** (Prefix: `s`)

- `s a` (Add): **Add** surround.
  - _Ex:_ `saw"` (Surround Word with `"`) → turns `hello` into `"hello"`
- `s d` (Delete): **Delete** surround.
  - _Ex:_ `sd"` (Delete surrounding `"`) → turns `"hello"` into `hello`
- `s r` (Replace): **Replace** surround.
  - _Ex:_ `sr"(` (Replace `"` with `( )`) → turns `"hello"` into `( hello )`

#### **Mini.ai** (Better Text Objects)

- Extends `a` (around) and `i` (inside).
- **TreeSitter Objects:** You can now use `a f` (function) or `i c` (class).
  - _Ex:_ `vaf` (Visually select Around Function).
  - _Ex:_ `daf` (Delete Around Function).
- **Argument Objects:** `a a` (argument).
  - _Ex:_ `cia` (Change Inside Argument) → useful inside `(param1, param2)`.
