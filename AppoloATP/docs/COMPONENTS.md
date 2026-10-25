# Components

## ATPMker

**Source:** [`ATPMker.m`](../ATPMker.m)

**Purpose:** Main stateful renderer and report generator.

**Important properties:** `PPrSz_mm`, `res`, `file`, `Ch`, `DB`, `refCh`, and `elmnts`; dependent properties `PPrSz_pix` and `NElmnts`.

**Important methods:** `init`, `AddEl`, `Run`, `saveOneBits`, `getReport`, `makePreview`, `getfileByCh`, `getFullImg`.

**State/invariants:** `file` and `elmnts` are linked collections expected to expose `Head`, `next`, `len`, and `Append`/`append` behavior. `Run` assumes every element channel exists in `file`.

## elmnt and subclasses

- [`elmnt.m`](../elmnt.m) — base handle class storing `pos`, `sz_mm`, `ch`, `type`, `msk`, `isscanable`, `scanpos`, and `ChName`.
- [`OD.m`](../OD.m) — rectangular optical-density target; scan position equals its position.
- [`BiDir.m`](../BiDir.m) — bidirectional target with `dist`, `ref`, `H`, and `W`.
- [`Scan.m`](../Scan.m) — directional scan target with the same distance/reference concepts.
- [`Line.m`](../Line.m) — long line target; `getStepPos` generates scan positions along its width.

## Types

**Source:** [`Types.m`](../Types.m)

**Purpose:** Static raster-mask factory for `OD`, `Line`, `Scan`, and `BiDir` records.

**Dependencies:** pixel conversion functions, `BWMker.Mask_Stat`, and `mergeLR`.

**Important assumption:** `res` may be a two-component resolution for OD/registration or a scalar for line rendering, matching the existing calls.

## makeDB

**Source:** [`makeDB.m`](../makeDB.m)

**Signature:** `DB = makeDB()`

**Purpose:** Returns the complete layout/configuration struct.

**Important fields:** `ChColor`, `ChWhite`, `AllCh`, `NPH`, section starts, OD geometry, bidirectional/scan geometry, line geometry, and heat-stripe geometry.

## getInfo

**Source:** [`getInfo.m`](../getInfo.m)

**Signature:** `info = getInfo(obj,DB)`

**Purpose:** Generates standard ATP element records for color and white sections.

**Calls:** `ch2ind`, `PArray` methods, and `obj.PPrSz_mm`.

**Outputs:** Struct array containing type-specific fields such as `pos`, `sz`, `ch`, `msk`, `isscanable`, `dist`, `isref`, `H`, `W`, `stepSz`, and `cName`.

## getInfoNeonDB

**Source:** [`getInfoNeonDB.m`](../getInfoNeonDB.m)

**Signature:** `info = getInfoNeonDB(obj,DB)`

**Purpose:** Alternate Neon-oriented layout generator with explicit color/white line batches and hard-coded composite masks.

**Uncertain:** The intended distinction between this layout and `getInfo` is not documented in source comments beyond the function name and batch definitions.

## Utility functions

- [`AddCntrBW2A.m`](../AddCntrBW2A.m) — centers a binary mask at multiple positions and clips out-of-range coordinates.
- [`SplitInfo.m`](../SplitInfo.m) — partitions records by `type` into OD, BiDir/Scan, and Line groups, optionally appending heat-stripe records.
- [`applyFuncToImagesInF.m`](../applyFuncToImagesInF.m) — applies a callback to every image in a folder-tree object and saves the result.
- [`getETime.m`](../getETime.m) — maps channel/type to exposure time.
- [`invertCond.m`](../invertCond.m) — identifies OD channels requiring inversion.
- [`fixPos.m`](../fixPos.m) — adjusts selected OD report Y positions using adjacent rows.
- [`mergeOneBits.m`](../mergeOneBits.m) — logical-AND merges same-sized images from a folder tree.
- [`ch2ind.m`](../ch2ind.m) — maps one or more channel names to indices in `DB.AllCh`.
- [`estimateColorPoint.m`](../estimateColorPoint.m) — nearest-color classification for four RGB reference colors.
- [`getVerticalStartEndValues.m`](../getVerticalStartEndValues.m) — finds first/last nonzero column in a binary image.
- [`cropImgVerticalyByInd.m`](../cropImgVerticalyByInd.m) — crops columns between two indices.
- [`addHeatStripesToImgSize.m`](../addHeatStripesToImgSize.m), [`addHeatStripesToImageByData.m`](../addHeatStripesToImageByData.m), [`getHeatStripesByImgSize.m`](../getHeatStripesByImgSize.m) — create or suppress heat-stripe bands.
- [`ChannelData.m`](../ChannelData.m) — value object containing a binary image, channel name, and index.
