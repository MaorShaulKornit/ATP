# NATP MATLAB Project Overview

## Purpose

This project builds ATP (automatic test pattern) artwork for printhead/channel verification. It converts a database of physical layout parameters into typed pattern elements, rasterizes those elements into per-channel one-bit images, optionally adds heat-stripe regions, and emits a scan-location report.

The primary executable script is [`Test.m`](../Test.m). The implementation is parameterized in millimetres and converted to pixels using the project/toolbox conversion functions.

## Main entry points

- [`Test.m`](../Test.m) — primary end-to-end workflow. Creates four `ATPMker` objects, generates pattern descriptions with [`getInfo.m`](../getInfo.m), renders OD/registration/line groups, post-processes saved images, previews locations, and writes `Locations31.csv`.
- [`Test2.m`](../Test2.m) — alternate/older workflow. Intended to use `getInfoNeonDB`, adds heat stripes to split pattern groups, intersects saved images, and writes `Locations26.csv`. As checked in, it references `info` without initializing it because the `getInfoNeonDB` call is commented out.
- [`ViewR.m`](../ViewR.m) — low-resolution preview/report workflow at 100 dpi.
- [`makeDB.m`](../makeDB.m) — authoritative in-code configuration for channels, paper, geometry, masks, and offsets.

## Major subsystems

1. Configuration and pattern placement: [`makeDB.m`](../makeDB.m), [`getInfo.m`](../getInfo.m), [`getInfoNeonDB.m`](../getInfoNeonDB.m).
2. Pattern model: [`elmnt.m`](../elmnt.m), [`OD.m`](../OD.m), [`BiDir.m`](../BiDir.m), [`Scan.m`](../Scan.m), [`Line.m`](../Line.m).
3. Raster generation: [`ATPMker.m`](../ATPMker.m), [`Types.m`](../Types.m), [`AddCntrBW2A.m`](../AddCntrBW2A.m).
4. Image post-processing: [`applyFuncToImagesInF.m`](../applyFuncToImagesInF.m), heat-stripe functions, cropping, and one-bit merging.
5. Reporting and visualization: `ATPMker.getReport`, `ATPMker.makePreview`, [`fixPos.m`](../fixPos.m), and MATLAB plotting/export calls in the scripts.

## Important directories/files

- `docs/` — this generated documentation.
- `ATP_23.json` — large external-style frame description/configuration artifact; it is not loaded by `Test.m`.
- Runtime output directories such as `ATP_OD`, `ATP_Reg`, and `ATP_Lines` — created by `ATPMker.saveOneBits` and consumed by the scripts.

## External dependencies

The source calls APIs not defined in this folder. The most important are `CArray`, `PArray`, `BWMker`, `UnitConv`, `Sizes`, `KUtils`, `folderTree`, `mm2pix`, `mm2pix_rounded`, `pix2mm`, `linspace2D`, `mergeLR`, `toEmpty`, `removeOutOfRangeData`, and `PImage.SaveAsPNG`. These appear to come from the surrounding MATLAB/toolbox environment.

## Execution summary

`Test.m` creates `DB = makeDB`, initializes channel canvases through `ATPMker.init`, obtains a struct array of OD/BiDir/Scan/Line descriptions, normalizes missing size fields, splits the descriptions by type, adds them to separate makers, rasterizes them with `Run`, saves channel TIFFs, applies crop/heat-stripe functions, creates a preview/report, and writes `Locations31.csv`.

## Known caveats

- `ATPMker.getReport` assigns random voltage and PH values with `randi`; those fields are not deterministic.
- `Test.m` assumes `ATP_OD\ATP_OD_C.tif` exists after rendering and that external toolbox functions are on the MATLAB path.
- `Test2.m` is incomplete in its checked-in form because its `info` initialization is commented out.
