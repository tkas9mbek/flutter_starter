#!/usr/bin/env bash
# Logic-coverage report: runs the suite, filters generated/wiring files so the
# number means *logic* coverage (see docs/guides/testing.md §6), prints a
# per-layer breakdown (the "map of gaps"), and writes an HTML report.
#
# Usage: utils/coverage.sh        (from repo root)
set -euo pipefail
cd "$(dirname "$0")/.."

echo "▶ Running tests with coverage…"
fvm flutter test --coverage --concurrency 4 >/dev/null

echo "▶ Filtering generated + wiring files…"
lcov --remove coverage/lcov.info \
  '*.g.dart' '*.freezed.dart' '*.gr.dart' '*/main.dart' \
  '*/configs/*_module.dart' '*/di/*' '*/l10n/generated/*' \
  -o coverage/lcov.cleaned.info --ignore-errors unused >/dev/null 2>&1

echo "▶ Coverage by layer (logic-filtered):"
python3 - <<'PY'
from collections import defaultdict
def bucket(p):
    if '/ui/' in p and '/bloc/' in p: return '1. BLoC (logic)'
    if '/repository_executor/' in p or '/exceptions/' in p: return '4. Toolkit executor/exceptions'
    if '/data/' in p: return '2. Data sources (mock+remote)'
    if '/domain/' in p: return '3. Domain (repositories)'
    if p.startswith('packages/starter_uikit'): return '6. UIKit widgets'
    if '/ui/' in p: return '5. UI screens/widgets'
    return '7. other'
stats=defaultdict(lambda:[0,0]); sf=None; lf=lh=0
for ln in open('coverage/lcov.cleaned.info'):
    ln=ln.strip()
    if ln.startswith('SF:'): sf=ln[3:]
    elif ln.startswith('LF:'): lf=int(ln[3:])
    elif ln.startswith('LH:'): lh=int(ln[3:])
    elif ln=='end_of_record' and sf:
        b=bucket(sf); stats[b][0]+=lh; stats[b][1]+=lf; sf=None; lf=lh=0
tot=[0,0]; logic=[0,0]
print(f"  {'Layer':<34}{'Covered/Total':>16}{'Cov%':>8}")
print('  '+'-'*56)
for b in sorted(stats):
    lh,lf=stats[b]; tot[0]+=lh; tot[1]+=lf
    if b[0] in '1234': logic[0]+=lh; logic[1]+=lf
    print(f"  {b:<34}{f'{lh}/{lf}':>16}{(100*lh/lf if lf else 0):>7.1f}%")
print('  '+'-'*56)
print(f"  {'TOTAL (logic-filtered)':<34}{f'{tot[0]}/{tot[1]}':>16}{100*tot[0]/tot[1]:>7.1f}%")
print(f"  {'LOGIC ONLY (BLoC+Data+Domain+Exec)':<34}{f'{logic[0]}/{logic[1]}':>16}{100*logic[0]/logic[1]:>7.1f}%")
PY

echo "▶ Writing HTML report…"
genhtml coverage/lcov.cleaned.info -o coverage/html --quiet
echo "✓ Open coverage/html/index.html — coverage is a map of gaps, not a target."
