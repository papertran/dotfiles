## Cheat Sheet

### 🖥️ Interface (The Space Bar)

_These control VS Code windows, files, and tools._

| Command     | Shortcut         | Description                 |
| :---------- | :--------------- | :-------------------------- |
| **Files**   | `<Space> f f`    | Find File (Quick Open).     |
|             | `<Space> f g`    | Grep (Search in all files). |
|             | `<Space> e`      | Toggle File Explorer Tree.  |
|             | `<Space> p s`    | Switch Project.             |
| **Windows** | `<Space> w v`    | Split Vertical.             |
|             | `<Space> w s`    | Split Horizontal.           |
|             | `<Space> w q`    | Close current split.        |
|             | `Ctrl + h/j/k/l` | Focus Left/Down/Up/Right.   |
| **Tools**   | `<Space> g g`    | **Lazygit**.                |
|             | `<Space> =`      | Format Document.            |
|             | `Ctrl + \``      | Toggle Terminal.            |

### 🐞 Debugging (The F-Keys)

_Standard industry debug keys._

| Key             | Action             |
| :-------------- | :----------------- |
| **F5**          | Start / Continue.  |
| **Shift + F5**  | Stop.              |
| **F9**          | Toggle Breakpoint. |
| **F10**         | Step Over.         |
| **F11**         | Step Into.         |
| **Shift + F11** | Step Out.          |

### ⚡ Text & Navigation (Vim/LazyVim)

_These edit the code itself._

| Context      | Shortcut  | Action                                    |
| :----------- | :-------- | :---------------------------------------- |
| **Jump**     | `s`       | **Flash Jump** (Jump anywhere on screen). |
|              | `g d`     | Go to Definition.                         |
|              | `g D`     | Peek Definition (Inline).                 |
| **Refactor** | `g r`     | **Rename** Symbol (Safe Rename).          |
|              | `g b`     | **Add Cursor** (Multi-cursor).            |
| **Search**   | `/`       | Search within file (Vim style).           |
|              | `n` / `N` | Next / Previous match.                    |

### 🔠 LazyVim Objects (The "Mini" Plugins)

_Combine these with `c` (change), `d` (delete), `v` (visual)._

| Object        | Key           | Example                                     |
| :------------ | :------------ | :------------------------------------------ |
| **Quotes**    | `i q` / `a q` | `ciq` (Change inside quotes).               |
| **Brackets**  | `i b` / `a b` | `cib` (Change inside parenthesis/brackets). |
| **Arguments** | `i a` / `a a` | `cia` (Change function argument).           |
| **Surround**  | `sa`          | `saw"` (Surround word with `"`).            |
|               | `sd`          | `sd"` (Delete surrounding `"`).             |
|               | `sr`          | `sr'"` (Replace surrounding `'` with `"`).  |

---

## 3. Helpful Patterns & Workflows

### The "Mental Toggle"

- **Need a File or Tool?** -> Hit `Space`.
- **Need to Debug?** -> Hit `F5`.
- **Editing Code?** -> Stay in Vim mode.

### 1. The Fast Refactor

**Don't** backspace to rename a variable.

1.  Hover cursor over variable.
2.  `g r` -> Type new name -> Enter.
    _(This updates imports and references across all files)._

### 2. The Multi-Edit

**Don't** use `Cmd+D` spamming.

1.  Cursor on word.
2.  `g b` -> Adds cursor to next match.
3.  `g b` -> Adds another.
4.  `c` (Change) -> Type new text -> Esc.

### 3. The "Lazy" Search & Replace

**Don't** reach for the mouse to use the VS Code Find bar.

1.  Type `:%s/Old/New/g` in Normal mode.
2.  Hit Enter.
    _(Replaces "Old" with "New" in the whole file instantly)._

### 4. The Flash Navigation

**Don't** hold down `j` or `k` to scroll to a line.

1.  Look at where you want to go.
2.  Press `s`.
3.  Type the first letter of that word.
4.  Type the label letter that appears.
    _(Teleports cursor instantly)._

### 5. Lazygit Quick-Fix

1.  `<Space> g g` (Open Lazygit).
2.  `Space` on file to Stage.
3.  `c` to Commit.
4.  `q` to Quit and return to code.
