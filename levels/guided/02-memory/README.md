# Guided Path 02 - Memory

Basics and Breakpoints kept you at the level of named variables. Real bugs
often live one step removed from those — behind a pointer, inside an array
at a position you have to work out, in raw bytes `print` won't decode, in a
struct you only have a pointer to, or several hops down a chain of pointers.

| Exercise | Skill |
|----------|-------|
| `00-pointer-dereference` | `print *ptr`, `print &var` |
| `01-array-walk` | `print arr[i]`, indexing with a value found at runtime |
| `02-examine-memory` | `x`, reading raw bytes print does not decode |
| `03-struct-inspect` | `ptype`, `print ptr->field` |
| `04-memory-capstone` | chase a pointer chain, combining all of it |

Every exercise here gives you the goal and not the commands. Use `hint` when
you want a nudge; the full walkthrough is in each exercise README.

Prerequisite: [01 - Breakpoints](../01-breakpoints).
