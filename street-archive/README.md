# Streets

Generated: 2026-10-18, from `europe/germany/berlin` of download.geofabrik.de, by
`src/scripts/collect-streets/collect-streets.py` in specht/workspace.

The streets, paths and stairs (and ferries) of a region, one way per line,
tab-separated:

| Column | Meaning |
| --- | --- |
| kind | the `highway` tag of OpenStreetMap (`residential`, `footway`, `primary`, `steps`, …), or `ferry` |
| oneway | `yes` (only in the direction of the points), `-1` (only against it), or empty |
| name | the name of the street, or empty |
| points | `ID LON,LAT ID LON,LAT …`: the nodes of the way in order; ways that meet share the ID of the node where they meet |

The files, the whole region and its areas (a way belongs to every area one of
its points lies in):

- `berlin.tsv.gz`
- `mitte.tsv.gz`
- `friedrichshain-kreuzberg.tsv.gz`
- `pankow.tsv.gz`
- `charlottenburg-wilmersdorf.tsv.gz`
- `spandau.tsv.gz`
- `steglitz-zehlendorf.tsv.gz`
- `tempelhof-schoeneberg.tsv.gz`
- `neukoelln.tsv.gz`
- `treptow-koepenick.tsv.gz`
- `marzahn-hellersdorf.tsv.gz`
- `lichtenberg.tsv.gz`
- `reinickendorf.tsv.gz`

Next to each, `NAME-places.tsv` has public places to start from and go to,
`kind` (`sight`, `square` or `school`), `name` and `LON,LAT`. Never addresses.

Data © OpenStreetMap contributors, ODbL 1.0
(https://www.openstreetmap.org/copyright).
