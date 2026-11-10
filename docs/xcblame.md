# xcblame

Find out where your Xcode build time goes, and what to do about it.

xcblame runs `xcodebuild` for you (or reads a build log you already have) and produces a report
that answers three questions:

1. **How long did the build take, and which part of it was the bottleneck?**
2. **Which targets, files and settings cost the most?**
3. **What should I change first, and how much will it save?**

It is one Swift binary. It never modifies your project, and nothing leaves your machine.

## Install

```sh
brew tap iasaeed/tap
brew install xcblame
```

Needs macOS 14 or later and Xcode 26 or later. Check with `xcblame --version`.

## First report in two minutes

1. Build your app once in Xcode (Product → Build, or ⌘B).
2. In Terminal, inside your project folder:

```sh
xcblame analyze --format html --open
```

xcblame finds the latest build log in DerivedData and opens an HTML report in your browser.
Start with the **"Start here"** box at the top: it lists the biggest wins, ranked by measured seconds.

Or let xcblame run the build itself:

```sh
xcblame build --html -- -scheme MyApp -destination 'generic/platform=iOS Simulator'
```

Everything after `--` goes to `xcodebuild` unchanged.

## Everyday commands

| Want to… | Run |
|---|---|
| See the report for the last Xcode build | `xcblame analyze --format html --open` |
| Build and report in one go | `xcblame build --html -- -scheme MyApp` |
| Check project settings without building | `xcblame doctor MyApp.xcodeproj` |
| Understand why a small change rebuilt so much | `xcblame why -- -scheme MyApp` |
| Find the slowest functions to type-check | `xcblame build --deep -- -scheme MyApp` |
| Compare two builds | `xcblame compare before.json after.json` |
| See how build time changes over days | `xcblame trend --kind incremental` |
| Read what a finding means | `xcblame rules explain SET-001` |
| Verify a fix | `xcblame verify --rules SET-005 --kind clean -- -scheme MyApp` |
| Apply a kept fix | `xcblame fix --rules SET-005 --apply` |
| Deliver fixes on CI without editing the project | `xcblame build --overlay -- -scheme MyApp` |

## Fix and verify

`xcblame verify` builds your project several times with and without a proposed change, and keeps the change only when it is faster by more than the normal run-to-run noise and nothing broke. `xcblame fix --apply` then writes the kept changes as an xcconfig overlay file, which you can revert at any time. Nothing in your project file is edited. On CI, `xcblame build --overlay` builds with the same overlay, so the whole team and the pipeline get the saving without touching the project.

## Reading the report

Since 0.6.1 the first screen of the HTML report shows only the build time, the floor (the critical path), the waste and up to three actions to take first. Everything else is collapsed below it.

- **Build kind**: clean, incremental, zero-change or cached. Only compare builds of the same kind.
- **Critical path**: the chain of tasks that set the total time. Making anything off this chain faster does not shorten the build.
- **Xcode's own work**: planning, linking, code signing. Shown separately so you don't blame your code for it.
- **Fix plan**: concrete changes in a safe order, each with the Xcode setting name and the measured or estimated saving.
- **Glossary**: every term used in the report is defined in [REPORT.md](https://github.com/iasaeed/xcblame/blob/main/docs/REPORT.md).

## Use it in CI

```sh
# Save a baseline from recent good builds and commit it
xcblame baseline save --kind clean --last 5

# Fail the job if the build got 10 % slower than the baseline
xcblame build --format github --baseline .xcblame/baseline.json --fail-if-slower 10 -- -scheme MyApp
```

`--format github` writes a summary to the job page and annotates slow spots. Other CI formats: `json`,
`markdown` (PR comment), `junit`, `agent`. Reports that leave the machine are redacted by default
(user name, host, paths).

## Exit codes

| Code | Meaning |
|---|---|
| 0 | OK |
| 2 | Wrong arguments |
| 3 | Slower than the baseline (`--fail-if-slower`) |
| 4 | `doctor --fail-on` found a problem at that severity |
| 5 | Log, result bundle or project not found |

`xcblame build` returns xcodebuild's own exit code unless you pass `--exit-code xcblame`.

## Where files go

- `.xcblame/` in your project folder: history, reports, cache. Git-ignored except `baseline.json`.
- `~/Library/Caches/xcblame`: build-settings cache.
- Your project files: never touched.

## Help

```sh
xcblame --help
xcblame help build
```
