# ScanFlow - Architecture

## Project Objective

Build a high-performance mobile document scanner capable of scanning
500–1000 pages continuously without crashes or excessive memory usage.

The application prioritizes:

- Performance
- Reliability
- Low memory usage
- Large document support
- Clean architecture
- Offline-first operation

---

# Technology Stack

Framework
- Flutter

Language
- Dart

Image Processing
- OpenCV (opencv_dart)

Camera
- camera package

Storage
- Local Storage
- Session-based directory structure

Target Platforms

- Android (Primary)
- Windows (Development)

---

# Folder Structure

lib/

app/
core/
data/
shared/

features/

- home
- scanner
- document_processing
- editor
- pdf
- ocr
- gallery
- settings

docs/

---

# Core Principles

1. Never keep scanned pages permanently in RAM.

2. Every captured page is immediately written to disk.

3. Image processing happens one page at a time.

4. Thumbnails are stored separately.

5. Original capture is temporary.

6. Processed document becomes the final saved page.

7. UI never directly performs image processing.

8. Business logic stays inside Services.

9. Pages only display UI.

10. Project architecture is considered frozen unless a technical blocker is found.

---

# Data Flow

User

↓

Home

↓

New Scan

↓

Create Session

↓

Camera

↓

Capture

↓

Temporary Image

↓

ProcessingService

↓

Document Detection

↓

Perspective Correction

↓

Image Enhancement

↓

Processed Document

↓

Thumbnail Generation

↓

Save

↓

FilmStrip

↓

Preview

↓

PDF Export

↓

Finished

---

# Session Structure

ScanFlow/

sessions/

session_xxxxx/

pages/

thumbnails/

exports/

metadata.json

---

# Processing Pipeline

Capture

↓

Temporary Image

↓

ProcessingService

↓

ImagePreprocessor

↓

ContourDetector

↓

CornerOrdering

↓

DocumentDetector

↓

PerspectiveCorrector

↓

ImageEnhancer

↓

ProcessedDocument

↓

Thumbnail Generation

↓

Save Processed Image

---

# Memory Strategy

One image is processed at a time.

Only thumbnails remain visible.

Full-resolution pages are loaded only when required.

Target:

Support 500–1000 pages with stable memory usage.