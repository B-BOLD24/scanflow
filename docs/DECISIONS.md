# Architecture Decisions

---

Decision

Feature-first architecture.

Status

FINAL

Reason

Better scalability.

---

Decision

Session-based storage.

Status

FINAL

Reason

Supports large documents.

---

Decision

Save images immediately after capture.

Status

FINAL

Reason

Avoid data loss.

---

Decision

Use thumbnails instead of loading full images.

Status

FINAL

Reason

Reduce RAM usage.

---

Decision

Process one page at a time.

Status

FINAL

Reason

Constant memory usage.

---

Decision

Use OpenCV.

Status

FINAL

Reason

Reliable document detection and perspective correction.

---

Decision

Background document processing.

Status

FINAL

Reason

Continuous scanning without blocking camera.

---

Decision

Hybrid scanning workflow.

Status

FINAL

Reason

Fast capture with later verification.

---

Decision

ProcessingService owns the complete document processing pipeline.

Status

FINAL

Reason

Centralizes image loading, memory ownership, and orchestration while preventing duplicate image reads.

---

Decision

Separate DetectionResult from ProcessedDocument.

Status

FINAL

Reason

DetectionResult represents only document detection, while ProcessedDocument represents the final output of the processing pipeline. This keeps models focused and avoids a growing "God Object".