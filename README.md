# nextcloud-smb

My customized Nextcloud docker image. <br/>
It adds support for:
* SMB
* PDF OCR through <a href="https://github.com/R0Wi/workflow_ocr">this project</a>
* Face recognition through <a href="https://apps.nextcloud.com/apps/facerecognition">this project</a>
<br/>
It is built automatically when the nextcloud base image is updated.<br/>
<br/>
<br/>
Each branch tracks a specific Nextcloud version and autobuilds independently when the corresponding Docker Hub tag is updated.<br/>
Currently the default branch tracks the nextcloud <i>33-apache</i> image.<br/>
<br/>
To add a new version, create a branch and update the `FROM` line in the Dockerfile to point to the desired `nextcloud:<version>-apache` tag. The CI will automatically discover the branch and build it.
