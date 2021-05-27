Integration tests for augur clades.

  $ pushd "$TESTDIR" > /dev/null
  $ export AUGUR="../../bin/augur"

Run augur clades without --attribute-name. We expect the name to be "clade"

  $ ${AUGUR} clades \
  >  --tree clades/tree.nwk \
  >  --clades clades/clades.tsv \
  >  --mutations clades/nt_muts.json \
  >  --output-node-data "$TMP/default.json" > /dev/null

  $ python3 "$TESTDIR/../../scripts/diff_jsons.py"  "clades/expected-output-default.json" "$TMP/default.json"
  {}

Run augur clades with a custom --attribute-name

  $ ${AUGUR} clades \
  >  --tree clades/tree.nwk \
  >  --clades clades/clades.tsv \
  >  --mutations clades/nt_muts.json \
  >  --attribute-name custom \
  >  --output-node-data "$TMP/custom-attr.json" > /dev/null

  $ python3 "$TESTDIR/../../scripts/diff_jsons.py"  "clades/expected-output-custom-attr.json" "$TMP/custom-attr.json"
  {}

Ensure the only change between runs of `augur clades` is the attr name used
  $ cat "$TMP/default.json" | sed "s/clade/custom/" > "$TMP/default-now-custom.json"
  $ diff -u "$TMP/default-now-custom.json" "$TMP/custom-attr.json"

Cleanup
  $ rm -f "$TMP/default.json" "$TMP/custom-attr.json" "$TMP/default-now-custom.json"
