# Data Flow

## Primary `Test.m` flow

1. [`Test.m`](../Test.m) clears MATLAB state and selects `Res = [800,800]` dpi.
2. [`makeDB.m`](../makeDB.m) creates the layout database. `DB.PPRSz` is `'A3'`; positions and sizes are specified in millimetres.
3. Four [`ATPMker`](../ATPMker.m) instances are created. `init` allocates one A3 binary canvas per configured channel. The main object uses 800 dpi; the OD object uses 600 dpi for the OD output path.
4. [`getInfo.m`](../getInfo.m) creates an ordered struct array. Records represent `OD`, `BiDir`, `Scan`, or `Line` elements. Positions, sizes, channel names, masks, and scanability are retained in the struct.
5. `Test.m` fills missing `H/W` from `sz` and missing `sz` from `H/W`, then [`SplitInfo.m`](../SplitInfo.m) separates records into OD, registration, and line groups.
6. [`ATPMker.AddEl`](../ATPMker.m) converts each struct record to an `OD`, `BiDir`, `Scan`, or `Line` object and appends it to the maker’s linked element collection.
7. [`ATPMker.Run`](../ATPMker.m) iterates elements. [`Types.m`](../Types.m) creates a binary mask in pixels; `mm2pix_rounded` converts the element position; the mask is centered and overlaid with [`AddCntrBW2A.m`](../AddCntrBW2A.m).
8. Scan elements produce two directional masks. One half is written to the target channel and the other to `refCh`, controlled by the element’s `ref` flag.
9. `saveOneBits` writes per-channel one-bit TIFF output under `ATP_OD`, `ATP_Reg`, and `ATP_Lines` (subject to the script’s object/name pairing).
10. The script determines vertical content bounds from `ATP_OD\ATP_OD_C.tif`, crops the OD images, and applies heat-stripe masking to all output groups through [`applyFuncToImagesInF.m`](../applyFuncToImagesInF.m).
11. `getReport` emits a table of scanable element positions and derived metadata. `makePreview` creates an indexed-color RGB preview. The report is plotted and written to `Locations31.csv`.

## Element rasterization

1. `OD` creates a filled rectangle with `mm2pix_rounded(el.sz_mm,res)` dimensions.
2. `Line` creates a filled rectangle using its `[H,W]` dimensions and generates evenly spaced scan positions with `stepSz/2` endpoint offset.
3. `BiDir` creates two vertically separated halves, reverses one half, and merges left/right according to `ref`.
4. `Scan` creates directional alternatives and returns two masks; the renderer selects which mask goes to the target/reference channel.
5. `BWMker.Mask_Stat` applies the element’s mask/statistical transformation before overlay.

## Report flow

Only elements with `isscanable` true are included. For each scan position, `getReport` records type, X/Y position, channel, random voltage/PH, exposure time from [`getETime.m`](../getETime.m), inversion from [`invertCond.m`](../invertCond.m), reference status, and `ChName`. [`fixPos.m`](../fixPos.m) can adjust selected OD channel positions by neighboring rows, but is commented out in `Test.m`.

## Alternate heat-stripe flow

`Test2.m` is intended to generate groups with `getInfoNeonDB`, append heat-stripe records using [`addHSOD.m`](../addHSOD.m), [`addHSReg.m`](../addHSReg.m), and [`addHSLines.m`](../addHSLines.m), render them, and intersect folder images with [`mergeOneBits.m`](../mergeOneBits.m). The current script cannot complete without restoring the `info` initialization.
