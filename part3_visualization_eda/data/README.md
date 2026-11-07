# Instructor reference dataset

**This data is synthetic.** I could not download the public *Trending YouTube Video Statistics* files, so `generate_dataset.py`
builds files with the **same schema and the same kinds of mess** (fixed seed 42, fully reproducible). Real YouTube numbers are *not* in here,
and every "insight" in the solutions (e.g. Music stays on the list longest, News & Politics is a one-day spike, GB is Music-heavy) is something
the generator was told to do. Use it to run and check the solutions; give students the real files if you want real findings.

## Files
| File | Rows | Notes |
|---|---|---|
| `USvideos.csv` | 16,080 | 80 days × 200 videos + 80 duplicate rows |
| `GBvideos.csv` | 15,075 | 75 days × 200 + 75 duplicates |
| `INvideos.csv` | 15,075 | 75 days × 200 + 75 duplicates |
| `categories.csv` | 17 | `category_id, category_name`; ids 29, 30, 43 are never used (handy for LEFT JOIN questions) |
| `generate_dataset.py` | | regenerates everything: `python generate_dataset.py` |

Columns (same as the real files): `video_id, trending_date (yy.dd.mm), title, channel_title, category_id, publish_time (ISO), tags, views, likes, dislikes, comment_count, thumbnail_link, comments_disabled, ratings_disabled, video_error_or_removed, description`.

## Messiness deliberately built in (the answer key depends on these)
* 230 exact duplicate rows (80 + 75 + 75) · 92 rows flagged `video_error_or_removed` · 12 blank `likes`, 36 blank `comment_count` · ~3.5% missing `description` · `[none]` tags.
* `ratings_disabled` rows have 0 likes/dislikes; `comments_disabled` rows have 0 comments (genuine zeros, not errors).
* About 2% of country-level videos (360 of 15059) also trended in another country (reused ids): 134 videos in both US and GB, 20 in all three — so set-intersection tasks have small but non-trivial answers.

## Switching to the real dataset
1. Put the real country CSVs in each Part's `data/` folder. Some country files in the real dataset are not UTF-8: if `pd.read_csv` raises a decoding error, pass `encoding="latin-1"`.
2. The real dataset ships category JSON files, not `categories.csv`. Convert one (structure: `items[].id` and `items[].snippet.title` — please check against your copy):
```python
import json, pandas as pd
items = json.load(open("US_category_id.json"))["items"]
pd.DataFrame({"category_id": [int(i["id"]) for i in items],
              "category_name": [i["snippet"]["title"] for i in items]}).to_csv("categories.csv", index=False)
```
3. Re-run the notebooks. **The numbers quoted in the Markdown interpretations (Part 3 especially) will no longer match** — they were written from this synthetic data and must be re-read against the new outputs. Real data may also contain categories absent from your lookup and more varied `trending_date` problems.
