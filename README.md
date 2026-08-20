# nextcloud-smb

My customized Nextcloud docker image. <br/>
It adds support for:
* SMB
* PDF OCR through <a href="https://github.com/R0Wi/workflow_ocr">this project</a>
<br/>
It is built automatically when the nextcloud base image is updated.<br/>
<br/>
<br/>
Each branch tracks a specific Nextcloud version and autobuilds independently when the corresponding Docker Hub tag is updated.<br/>
Currently the default branch tracks the nextcloud <i>34-apache</i> image.<br/>
<br/>
To add a new version, create a branch and update the `FROM` line in the Dockerfile to point to the desired `nextcloud:<version>-apache` tag. The CI will automatically discover the branch and build it.<br/>
<br/>
A branch can also be built on demand: run the workflow manually and set `force_branches` to a
comma-separated list of branches (or `all`). This bypasses the "base image changed in the last 24h"
check, which is otherwise never true for a freshly created version branch.

## Dropped: face recognition

Support for <a href="https://apps.nextcloud.com/apps/facerecognition">facerecognition</a> was
removed starting with Nextcloud 34. The image no longer builds `dlib` or the `pdlib` PHP extension.

Why:
* **The app itself stopped.** Its newest release, 0.9.70, declares support for Nextcloud 31 only.
  There is no release for 32, 33 or 34, so the app cannot be installed on a current server
  regardless of what this image provides.
* **Its dependency is unmaintained.** `pdlib` (<a href="https://github.com/goodspb/pdlib">goodspb/pdlib</a>)
  has had no commit since September 2023, which predates PHP 8.5 — the version shipped by the
  `nextcloud:34-apache` base image.

Removing it also drops a from-source `dlib` compile, which was by far the slowest layer in the
build.<br/>
<br/>
Branches for Nextcloud 31 and earlier still carry the extension, and those are the only versions
where the app can actually run. The `nextcloud32` and `nextcloud33` branches still build it too,
but nothing can use it there.
