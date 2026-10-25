# Architecture

## Configuration database

**Purpose:** Defines the A3 paper, channel groups, section origins, pattern dimensions, offsets, masks, and heat-stripe settings.

**Source:** [`makeDB.m`](../makeDB.m)

**Responsibilities:** Builds the `DB` struct consumed by placement functions and the renderer. Coordinates are primarily millimetres; channel masks are scalar values indexed according to `DB.AllCh`.

**Depends on:** `Sizes.PH_508_mm`.

**Used by:** `Test.m`, `Test2.m`, `ViewR.m`, `getInfo.m`, `getInfoNeonDB.m`, and heat-stripe augmentation functions.

**Important state:** `NPH=3`; color channels are `C,M,Y,K,R,G`; white/light channels are `W1,W2,W3,W4,Ic,Qc,Iw,Qw`; reference channel is usually `K`.

## Pattern description generation

**Purpose:** Converts configuration into an ordered struct array named `info`.

**Source:** [`getInfo.m`](../getInfo.m), [`getInfoNeonDB.m`](../getInfoNeonDB.m)

**Responsibilities:** Places OD squares, bidirectional/scan registration targets, and line batches for color and white sections. Each record carries `type`, `pos`, channel(s), mask(s), dimensions, scanability, and optional names.

**Depends on:** `DB`, `ATPMker.PPrSz_mm`, `PArray`, `ch2ind`.

**Used by:** `Test.m` and alternate workflows.

**Important assumptions:** Position vectors use the project’s `[Y,X]`-like convention as passed to `mm2pix_rounded`; exact axis semantics are not independently documented in this folder.

## Pattern object model

**Purpose:** Represents logical test elements before rasterization.

**Source:** [`elmnt.m`](../elmnt.m), [`OD.m`](../OD.m), [`BiDir.m`](../BiDir.m), [`Scan.m`](../Scan.m), [`Line.m`](../Line.m)

**Responsibilities:** Stores positions, millimetre sizes, channels, masks, scanability, scan positions, and display names. Subclasses add type-specific dimensions and reference/distance state.

**Depends on:** MATLAB handle classes and `linspace2D` for line scan positions.

**Used by:** `ATPMker.AddEl` and `ATPMker.Run`.

## Raster renderer

**Purpose:** Owns per-channel canvases and overlays rasterized element masks.

**Source:** [`ATPMker.m`](../ATPMker.m), [`Types.m`](../Types.m), [`AddCntrBW2A.m`](../AddCntrBW2A.m)

**Responsibilities:** Initializes channel images, converts element records to objects, generates binary masks, places masks at rounded pixel coordinates, saves one-bit files, creates previews, and produces reports.

**Depends on:** `CArray`, `ChannelData`, conversion utilities, `BWMker`, `mergeLR`, and image-save APIs.

**Used by:** all executable scripts.

**Important state:** `file` is a linked collection of `ChannelData`; `elmnts` is a linked collection of pattern objects; `refCh` receives the reference half of scan patterns.

## Image post-processing

**Purpose:** Crops channel images and suppresses/adds heat-stripe regions after rendering.

**Source:** [`applyFuncToImagesInF.m`](../applyFuncToImagesInF.m), [`cropImgVerticalyByInd.m`](../cropImgVerticalyByInd.m), [`addHeatStripesToImgSize.m`](../addHeatStripesToImgSize.m), [`addHeatStripesToImageByData.m`](../addHeatStripesToImageByData.m), [`getHeatStripesByImgSize.m`](../getHeatStripesByImgSize.m)

**Responsibilities:** Applies a function to each image in a `folderTree`, detects vertical bounds, and masks heat-stripe bands using statistical binary-mask operations.

**Depends on:** `folderTree`, `BWMker`, and image readers.

**Used by:** `Test.m` and `Test2.m`.
